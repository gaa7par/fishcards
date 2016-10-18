require 'capybara/rspec'
require 'capybara/email/rspec'
module CapybaraHelpers
  def reload_page
    visit(page.current_url)
  end

  def using_second_browser(&block)
    # NOTE: Using the same session name everywhere to save spec time.
    Capybara.using_session(:second_browser) do
      page.driver.browser.manage.window.resize_to(1920, 1080) unless page.mode == :rack_test
    end
    Capybara.using_session(:second_browser, &block)
  end
end
RSpec.configure do |config|
  config.include CapybaraHelpers
  config.after(:each) do
    clear_emails if is_a?(Capybara::Email::DSL)
  end
  config.before(:each, js: true) do
    Capybara.page.driver.browser.manage.window.resize_to(1920, 1080)
  end
end
# Prevents requests from hitting the Rails app after the test has finished.
class CapybaraRequestBlockerMiddleware
  # assignment to initialized instance variables is thread safe in Ruby
  @enabled = false
  class << self
    def enabled?
      @enabled
    end

    def enable!
      @enabled = true
    end

    def disable!
      @enabled = false
    end
  end
  def initialize(app)
    @app = app
  end

  def call(env)
    if self.class.enabled?
      @app.call(env)
    else
      [200, {}, ['Request blocked by block middleware']]
    end
  end
end
Capybara.app = CapybaraRequestBlockerMiddleware.new(Rails.application)
Capybara.javascript_driver = :selenium
Capybara.default_max_wait_time = 5
Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['focusmanager.testmode'] = true
  Capybara::Selenium::Driver.new(app, profile: profile)
end
