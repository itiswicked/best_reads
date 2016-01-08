require 'rails_helper'

feature 'users views profiles' do
  let!(:user) do
    user = FactoryGirl.create(:user)
    user
  end

  scenario 'logged in and views own profile' do
    login_as(user, scope: :user)
    visit user_path(user)

    expect(page).to have_content user.first_name
    expect(page).to have_content user.first_name
    expect(page).to have_content user.email
    expect(page).to have_content 'Edit Profile'
  end

  scenario 'logged in and views other user\'s profile' do
    login_as(user, scope: :user)
    visit user_path(user)
    user2 = FactoryGirl.create(:user)
    visit user_path(user2)

    expect(page).to_not have_content 'Edit Profile'
  end

  scenario 'not logged in cannot view any profile' do
    visit user_path(user)
    expect(page).to have_content 'You are not authorized to view this.'
  end
end
