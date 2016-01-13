require 'rails_helper'

feature 'users can upvote and downvote reviews' do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:author) { FactoryGirl.create(:author) }
  let!(:genre) { FactoryGirl.create(:genre) }
  let!(:book) do
    FactoryGirl.create(:book,
    user_id: user.id,
    author_id: author.id,
    genre_id: genre.id)
  end
  let!(:review) do
    FactoryGirl.create(:review,
    user_id: user.id,
    book_id: book.id)
  end

  scenario 'user votes on a review' do
    login_as(user, scope: :user)
    visit book_path(book.id)

    click_link "Upvote This Review"

    expect(page).to have_content("1")
    # expect(page).to have_content("Undo Upvote")
    # expect(page).to_not have_content("Downvote This Review")
  end

  scenario 'user un-votes' do
    login_as(user, scope: :user)
    visit book_path(book.id)
    click_link "Upvote This Review"
    visit book_path(book.id)
    click_link "Undo Upvote"

    expect(page).to have_content("Upvotes: 0")
    expect(page).to have_content("Upvote This Review")
    expect(page).to have_content("Downvote This Review")
  end
end
