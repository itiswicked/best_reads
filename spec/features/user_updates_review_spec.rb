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

  scenario 'from book\'s show page' do
# binding.pry
    login_as(users_review.user, scope: :user)
    visit book_path(users_review.book)

    expect(page).to have_content users_review.title
    expect(page).to have_content other_review.title

    users_review_elem = page.find('li', text: users_review.title)
    expect(users_review_elem).to have_content 'Udpate'

    click_link 'Update'
  end

  scenario 'from their profile page'

  scenario 'but not their own review'
end
