require 'rails_helper'

feature 'user views lots of books via pagination' do

# As a user
# I want to view lots of books
# without all books being loaded ahead of time

# Acceptance Criteria:
#
# [x] When visiting the root or books index page, a user should see a list of 20 books.
# [x] When a user clicks 'Next', 20 more books are loaded.
# [x] This feature should function correctly before JS functionality is added
# [ ] JS Functionality: When the user scrolls to the bottom of the page, more books are loaded automatically without a page refresh and the 'more books' button goes away.
# [x] Pagination should be handled by the Kaminari gem
#
# [Kaminari](https://github.com/amatsuda/kaminari)
# [Kaminari Docs](http://inch-ci.org/github/amatsuda/kaminari)

  21.times do |i|
    let!("book#{i+1}".to_sym) { FactoryGirl.create(:dynamic_book) }
  end

  scenario 'scrolls to the bottom and does not see more than 20 books' do
    visit books_path

    expect(page).to have_content book1.title
    expect(page).to have_content book20.title
    expect(page).to_not have_content book21.title
  end

  scenario 'scrolls to the bottom and wants to see more than 20 books' do
    visit books_path
    click_link 'Next'

    expect(page).to have_content book21.title
  end

end
