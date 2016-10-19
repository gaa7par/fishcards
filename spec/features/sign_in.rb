require 'rails_helper'

RSpec.feature 'Sign in' do
  let!(:user) { create(:user, email: 'alpha@example.com', password: 'secret') }

  scenario 'user logs in' do
    visit new_user_session_path

    fill_in 'user_email', with:  'alpha@example.com'
    fill_in 'user_password', with: 'secret'
    click_button('Log in')

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_current_path(root_path)
  end
end
