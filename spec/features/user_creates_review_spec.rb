require 'rails_helper'

feature 'user creates book review', %{
As a user I want to create a review
that is associated with a book
so I can tell others what I think of the book
} do
  # Acceptance Criteria:
  #
  # [√] A user should be able to title their review, required field
  # [√] A user should be able to leave a review no greater than 500 words
  # [√] A user should be able to rate a book on a 1 to 5 scale
  # [√] A user should be able to rate the book on a 1 to 5 scale
  # [√] A user should not be able to submit more than one review to a book
  # [√] The review should be associated with a book
  # [√] The review should have a starting vote of 0

  let!(:author) { Author.create(name: "Jane Doe") }
  let!(:genre) { Genre.create(genre_name: "Comedy") }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:book) do
    Book.create(title: 'Book Title',
                description: 'Book description!',
                year: 1988,
                genre_id: genre.id,
                author_id: author.id,
                user_id: user.id)
  end

  scenario 'an authenticated user supplies valid review information' do
    login_as(user, scope: :user)

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
    login_as(user, scope: :user)

    visit books_path

    click_link 'Book Title'
    click_link 'Add Review'

    click_button 'Add Review'

    expect(page).to have_content("Rating can't be blank")
  end

  scenario 'an unauthenticated user cannot create a review' do
    visit books_path
    click_link 'Book Title'

    expect(page).to_not have_content('Add Review')
    expect(page).to have_content('Sign in to add a review!')
  end

  scenario 'a user cannot review a book more than once' do
    login_as(user, scope: :user)

    visit books_path
    click_link 'Book Title'
    click_link 'Add Review'

    fill_in 'Title', with: 'Good book I guess'
    select '4', from: 'Rating'
    fill_in 'Review', with: 'This book is good for the most part'
    click_button 'Add Review'

    expect(page).to_not have_content("Add Review")
  end
end
