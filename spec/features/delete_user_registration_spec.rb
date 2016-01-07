require 'rails_helper'

# As a user
# I should be able to delete my account
# so I can no longer be subscribed to the service
#
# Acceptance Criteria
#
# [x] A user should be able to click a button to delete an account
# [x] A user should be a prompted with a confirmation for account deletion
# [x] Once an account is deleted, a user should be logged out and re routed to the home page.
# [x] A user should should not exist in the database once their account has been deleted.
# [x] All books and reviews associated with that user are deleted

feature 'User deletes their existing account' do
  scenario 'User visits Edit Account page to delete their account', :driver => :selenium do

    visit '/'
    click_link 'Sign Up'
    fill_in 'First name', with: 'Foo'
    fill_in 'Last name', with: 'Bar'
    fill_in 'Email', with: 'foo1@bar.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign Up'
    click_link 'Sign Out'

    click_link 'Sign In'
    fill_in "Email", with: 'foo1@bar.com'
    fill_in "Password", with: 'password'

    click_button 'Sign In'
    click_link 'Edit Profile'
    click_button 'Cancel my account'

    popup = page.driver.browser.switch_to.alert
    popup.accept
    expect(page).to have_content "Bye! Your account has been successfully
                                  cancelled."

    click_link 'Sign In'
    fill_in "Email", with: 'foo1@bar.com'
    fill_in "Password", with: 'password'

    click_button 'Sign In'

    expect(page).to have_content "Invalid email or password."
  end
end
