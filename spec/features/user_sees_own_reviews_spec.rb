require 'rails_helper'

feature 'user can see all reviews left on books', %{
  As a user,
  I want to see all the reviews I have left on books
  So that I can see all my reviews
} do

    # Acceptance Criteria
    #
    # [√] I want to see all of my reviews from my profile page

  scenario 'user sees all reviews from profile page' do
    user = FactoryGirl.create(:user)
    author = FactoryGirl.create(:author)
    genre = FactoryGirl.create(:genre)
    book = FactoryGirl.create(
      :book,
      user_id: user.id,
      author_id: author.id,
      genre_id: genre.id)
    review = FactoryGirl.create(
      :review,
      user_id: user.id,
      book_id: book.id)

    login_as(user, scope: :user)
    visit user_path(user.id)

    expect(page).to have_content("Your reviews:")
    expect(page).to have_content(review.title)
    expect(page).to have_content(review.body)
  end
end
