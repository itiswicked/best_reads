require 'rails_helper'

feature "user receives an email when a new
review is posted on a book they created", %{
As a user
I want to receive an email
when somebody posts a review on a book I've submitted
} do
  # Acceptance Criteria
  # [] As a user, I want to receive an email when
  #    another user posts a review on a book I created

  scenario "review a book" do
    user = FactoryGirl.create(:user)
    genre = FactoryGirl.create(:genre)
    author = FactoryGirl.create(:author)
    book = FactoryGirl.create(:book, author: author, user: user, genre: genre)

    login_as(user, scope: :user)

    visit new_book_review_path(book)

    fill_in 'Title', with: 'Good book I guess'
    select '4', from: 'Rating'
    fill_in 'Review', with: 'This book is good for the most part'
    click_button 'Add Review'

    expect(page).to have_content("Good book I guess")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
