require 'rails_helper'

feature 'user can delete their own reviews', %{
  As a user,
  I want to delete my own reviews,
  So that no one can see them
} do

  # Acceptance Criteria
  # [√] I can delete my reviews from my profile page
  # [√] If I delete a review, no one can see them anymore

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

  scenario "user can delete a review" do
    login_as(user, scope: :user)
    visit user_path(user.id)
    click_button "Delete This Review"

    expect(page).to_not have_content("Review Title!")
  end
end
