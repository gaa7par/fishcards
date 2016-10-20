Spec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion)
  end
  config.before(:each) do
    DatabaseCleaner.strategy = RSpec.current_example.metadata.fetch(:database_cleaner, :transaction)
  end
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.before do
    CapybaraRequestBlockerMiddleware.enable!
  end
  config.after do
    CapybaraRequestBlockerMiddleware.disable!
    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end
end
