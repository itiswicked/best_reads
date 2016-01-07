require 'rails_helper'

feature 'user creates book review', %{
As a user I want to create a review
that is associated with a book
so I can tell others what I think of the book
} do
# Acceptance Criteria:
#
# [ ] A user should be able to title their review, required field.
# [ ] A user should be able to leave a review no greater than 500 words
# [ ] The review should be associated with a book.

  before(:each) do
    author = Author.create(name: "Jane Doe")
    genre = Genre.create(genre_name: "Comedy")
    book = Book.create(title: 'Book Title', description: 'Book description!', year: 1988, genre_id: 1, author_id: 1)
  end

  scenario 'an authenticated user supplies valid review information' do
    user = FactoryGirl.create(:user)

    visit books_path
    click_link 'Book Title'
    click_link 'Add Review'

    fill_in 'Title', with: 'Good book I guess'
    select '4', from: 'Rating'
    fill_in 'Body', with: 'This book is good for the most part'
    click_button 'Add Review'

    expect(page).to have_content('Good book I guess')
    expect(page).to_not have_content('Add Review')
  end

  scenario 'an invalid form is not saved' do


  end

  scenario 'an unauthenticated user cannot create a review' do

  end
end
