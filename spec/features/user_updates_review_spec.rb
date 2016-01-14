require 'rails_helper'
extend UpdateReviewsHelpers

feature 'user updates review' do
  # As a user
  # I want to be able to update my own reviews
  # because my original opinion was bad and I should feel bad
  #
  # Acceptance Criteria:
  # [ ] User should be able to update any review from their profile page as
  #     described below.
  # [ ] When viewing my own review on a book's show page, there should be an
  #     edit button next to that review only.
  # [ ] The button leads to the review's show page, with pre-populated data.
  # [ ] Upon successful form submission, A user is redirected to the book's show
  #     page, with the message "Review updated successfully!"
  # [ ] Upon unsuccessful form submission, the edit page is re-rendered with the
  #     appropriate errors.

  let!(:users_review) { FactoryGirl.create(:review) }
  let!(:other_review) { FactoryGirl.create(:review, book: users_review.book) }

  before(:each) { login_as(users_review.user, scope: :user) }

  scenario 'accesses from book\'s show page' do
    visit book_path(users_review.book)

    expect(page).to have_content users_review.title
    expect(page).to have_content other_review.title

    click_button 'Edit'
    expect_fields_autopopulated
    fill_in_update_form

    expect(page).to have_content users_review.book.title
  end

  scenario 'accesses from their profile page' do
    visit user_path(users_review.user)

    click_button 'Edit'
    expect_fields_autopopulated
    fill_in_update_form

    expect(page).to have_content "Hello #{users_review.user.first_name}!"
  end

  scenario 'but not others reviews' do
    visit book_path(users_review.book)

    others_review_elem = page.find('li', text: other_review.title)
    expect(others_review_elem).to_not have_content 'Edit'
  end
end
