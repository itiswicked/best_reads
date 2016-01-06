require 'rails_helper'

# As a user
# I want to edit my account
# so I can keep my information up-to-date
#
# Acceptance Criteria:
#
# [x] The form to be edited should be pre-populated with user's existing
# =>  information.
# [x] A user should be able to edit their first name
# [x] A user should be able to edit their last name
# [x] A user should be able to edit their email
# [x] A user must input their current password to update info
# [ ] A user should be able to edit their password
# [ ] There should be a password confirmation when a password is to be changed


feature 'User edits their existing account' do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do

    visit '/'
    click_link 'Sign In'
    fill_in "Email", with: user.email
    fill_in "Password", with: 'password'
    click_button 'Sign In'

    visit edit_user_registration_path(user)
  end

  scenario 'User visits edit page and sees existing information' do
    expect(find_field('First Name').value).to eq user.first_name
    expect(find_field('Last Name').value).to eq user.last_name
    expect(find_field('Current password').value).to be_nil
  end

  scenario 'User edits with new valid information' do

    fill_in 'First Name', with: 'Sam'
    fill_in 'Last Name', with: 'Mendes'
    fill_in 'Email', with: 'sam@coolmovies.com'
    fill_in 'Current password', with: 'password'

    click_button 'Update'

    expect(page).to have_content 'Your account has been updated successfully.'
    visit edit_user_registration_path

    expect(find_field('First Name').value).to eq 'Sam'
    expect(find_field('Last Name').value).to eq 'Mendes'
  end

  scenario 'User does not provide information' do

    click_button 'Update'

    expect(page).to have_content "Current password can't be blank"
  end
end
