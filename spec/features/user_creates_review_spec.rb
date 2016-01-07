require 'rails_helper'

feature 'user creates book review', %{
As a user I want to create a review
that is associated with a book
so I can tell others what I think of the book
} do
# Acceptance Criteria:
#
# [√] A user should be able to title their review, required field.
# [√] A user should be able to leave a review no greater than 500 words
# [√] A user should be able to rate a book on a 1 to 5 scale
# [√] A user should be able to rate the book in their review on a 1 to 5 scale
# [√] A user should not be able to submit more than one review to a single book.
# [√] The review should be associated with a book.
# [√] The review should have a starting vote of 0.

  before(:all) do
    author = Author.create(name: "Jane Doe")
    genre = Genre.create(genre_name: "Comedy")
    user = FactoryGirl.create(:user)
    book = Book.create(title: 'Book Title', description: 'Book description!', year: 1988, genre_id: 1, author_id: 1, user_id: 1)
  end

  scenario 'an authenticated user supplies valid review information' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit books_path
    click_link 'Book Title'
    click_link 'Add Review'

    fill_in 'Title', with: 'Good book I guess'
    select '4', from: 'Rating'
    fill_in 'Review', with: 'This book is good for the most part'
    click_button 'Add Review'

    expect(page).to have_content('Good book I guess')
    expect(page).to have_content(user.first_name)
  end

  scenario 'an invalid form is not saved' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit books_path

    click_link 'Book Title'
    click_link 'Add Review'

    click_button 'Add Review'

    expect(page).to have_content('Review not created')
  end

  scenario 'an unauthenticated user cannot create a review' do
    visit books_path
    click_link 'Book Title'

    expect(page).to_not have_content('Add Review')
  end

  scenario 'a user cannot review a book more than once' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit books_path
    click_link 'Book Title'
    click_link 'Add Review'

    fill_in 'Title', with: 'Good book I guess'
    select '4', from: 'Rating'
    fill_in 'Review', with: 'This book is good for the most part'
    click_button 'Add Review'

    click_link 'Add Review'
    fill_in 'Title', with: 'Good book I guess'
    select '4', from: 'Rating'
    fill_in 'Review', with: 'This book is good for the most part'
    click_button 'Add Review'
    save_and_open_page
    expect(page).to have_content("You've already written a review for this book.")
  end
end
