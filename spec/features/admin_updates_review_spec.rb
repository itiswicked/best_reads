require 'rails_helper'

feature 'admin updates or deletes review' do
# As an administrator
# I want to be able to edit and delete any review
# if the content is deemed inappropriate
#
# Acceptance Criteria:
#
# [ ] A user flagged as an admin will have the admin privilege of editing/
# =>  deleting any review
  # let!(:user) {FactoryGirl.create(:user)}
  let!(:user) {FactoryGirl.create(:user, role: 'admin')}
  let!(:users_review) { FactoryGirl.create(:review) }
  let!(:other_review) { FactoryGirl.create(:review, book: users_review.book) }

  include UpdateReviewsHelpers
  before(:each) { login_as(user, scope: :user) }

  scenario 'accesses from book\'s show page' do
    visit book_path(users_review.book)

    expect(page).to have_content users_review.title
    expect(page).to have_content other_review.title
    expect(page).to have_button('Edit')
    expect(page).to have_button('Edit')
    expect(page).to have_button('Delete')
    expect(page).to have_button('Delete')
    click_button('Edit', match: :first)
    expect_fields_autopopulated
    fill_in_and_submit_form

    expect(page).to have_content users_review.book.title

    visit book_path(users_review.book)
    expect(page).to have_button('Edit')
    expect(page).to have_button('Edit')
    expect(page).to have_button('Delete')
    expect(page).to have_button('Delete')
    click_button('Delete', match: :first)


    expect(page).to_not have_button('Edit')
    expect(page).to_not have_button('Delete')
  end
end
