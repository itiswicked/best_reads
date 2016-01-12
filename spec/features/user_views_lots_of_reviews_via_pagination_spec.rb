require 'rails_helper'

feature 'user views lots of reviews via pagination' do

# As a user
# I want to view lots of reviews
# without all books being loaded ahead of time
#
# Acceptance Criteria:
# [x] When visiting the root or books index page, a user should see a list of
#     20 reviews.
# [x] When a user clicks 'More Reviews', 20 more reviews are loaded.
# [x] This feature should function correctly before JS functionality is added
# [ ] JS Functionality: When the user scrolls to the bottom of the page,
#     more books are loaded automatically without a page refresh and the
#     'more reviews' button goes away.
# [x] Pagination should be handled by the Kaminari gem

  let!(:book) { FactoryGirl.create(:book) }

  # Sleep gauarantees created_at timestamps are unique
  21.times do |i|
    let!("review#{i + 1}".to_sym) do
      FactoryGirl.create(:review, book: book)
    end
    sleep(1)
  end

  scenario 'scrolls to the bottom and does not see more than 20 reviews' do
    visit book_path(book)

    expect(page).to have_content review1.title
    expect(page).to have_content review20.title
    expect(page).to_not have_content review21.title
  end

  scenario 'scrolls to the bottom and wants to see more than 20 reviews' do
    visit book_path(book)
    click_link 'Next'

    expect(page).to have_content review21.title
  end
end
