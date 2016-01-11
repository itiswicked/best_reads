require 'rails_helper'

# As an administrator
# I want to be able to sign up, log in, and log out
# To be able to edit the settings and content of the site
#
# Acceptance Criteria:
#
# [] Allows someone to log in as Administrator
# [] Allows someone to log out as Administrator

feature 'User logs in as an Administrator' do
  scenario 'User navigates to Administrator login view and signs in' do
    admin = Admin.create(first_name: 'Joe',
                         last_name: 'Schmoe',
                         email: 'example@example.com',
                         password: 'password',
                         password_confirmation: 'password')
    visit root_path
    click_link 'Sign In'
    click_link 'Log in as Admin'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'
    expect(page).to have_content('Welcome Back!')
    expect(page).to have_content('Sign Out as Admin')
  end
end
