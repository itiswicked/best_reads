require 'rails_helper'

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

  def expect_fields_autopopulated
    expect(find_field('Title').value).to eq users_review.title
    expect(find_field('Review').value).to eq users_review.body
  end

  def fill_in_form
    fill_in 'Title', with: 'I hated it so much'
    fill_in 'Review',
            with: 'So much that flames were coming out the sides of my face'
    select '4', from: 'Rating'
    click_button 'Update Review'
  end

  scenario 'accesses from book\'s show page' do
    visit book_path(users_review.book)

    expect(page).to have_content users_review.title
    expect(page).to have_content other_review.title

    users_review_elem = page.find('li', text: users_review.title)

    click_button 'Edit'
    expect_fields_autopopulated
    fill_in_form

    expect(page).to have_content users_review.book.title
  end

  scenario 'accesses from their profile page' do
    visit user_path(users_review.user)

    click_button 'Edit'
    expect_fields_autopopulated
    fill_in_form

    expect(page).to have_content "Hello #{users_review.user.first_name}!"
  end

  scenario 'but not others reviews' do
    visit book_path(users_review.book)

    others_review_elem = page.find('li', text: other_review.title)
    expect(others_review_elem).to_not have_content 'Edit'
  end
end
