require 'rails_helper'

feature 'user signs out', %{
  As an authenticated user
  I want to sign out
  So that no one else can post items or reviews on my behalf
} do
  # Acceptance Criteria:
  # [] If I am an authenticated user, I can click a button to sign out.
  # [] If I am signed out, I can't sign out again.

  before :each do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end

  scenario 'an authenticated user can sign out' do
    visit root_path
    click_link 'Sign Out'

    expect(page).to have_content('Signed out successfully')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
  end
end
