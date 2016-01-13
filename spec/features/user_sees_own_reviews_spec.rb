require 'rails_helper'

feature 'user can see all reviews left on books', %{
  As a user,
  I want to see all the reviews I have left on books
  So that I can see all my reviews
} do

  # Acceptance Criteria
  #
  # [√] I want to see all of my reviews from my profile page

  let!(:user) { FactoryGirl.create(:user) }
  let!(:author) { FactoryGirl.create(:author) }
  let!(:genre) { FactoryGirl.create(:genre) }
  let!(:book) do FactoryGirl.create(
    :book,
    user_id: user.id,
    author_id: author.id,
    genre_id: genre.id)
  end
  let!(:review) do FactoryGirl.create(
    :review,
    user_id: user.id,
    book_id: book.id)
  end

  scenario 'user sees all reviews from profile page' do
    review = FactoryGirl.create(:review)
    user = review.user

    login_as(user, scope: :user)
    visit user_path(user)

    expect(page).to have_content("Your reviews:")
    expect(page).to have_content(review.title)
    expect(page).to have_content(review.body)
  end
end
