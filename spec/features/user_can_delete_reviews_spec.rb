require 'rails_helper'

feature 'user can delete their own reviews', %{
  As a user,
  I want to delete my own reviews,
  So that no one can see them
} do

  # Acceptance Criteria
  # [√] I can delete my reviews from my profile page
  # [√] If I delete a review, no one can see them anymore
  # [] No one else can delete my reviews

  let!(:other_user) { FactoryGirl.create(:user) }
  let!(:book) { FactoryGirl.create(:book) }
  let!(:review) do
    FactoryGirl.create(
      :review,
      title: "Review Title!",
      user: book.user,
      book: book
    )
  end

  scenario "user can delete a review" do
    login_as(book.user, scope: :user)
    visit user_path(book.user)
    click_button "Delete"

    expect(page).to_not have_content("Review Title!")
  end

  scenario "I cannot delete another user's review" do
    login_as(book.user, scope: :user)
    visit user_path(other_user.id)

    expect(page).to_not have_content("Delete")
  end
end
