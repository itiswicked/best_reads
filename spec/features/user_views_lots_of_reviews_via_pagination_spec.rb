require 'rails_helper'

feature 'user views lots of reviews via pagination' do

  let!(:dynamic_book) do
    b = FactoryGirl.build(:dynamic_book)
    b.author = FactoryGirl.create(:author)
    b.user = FactoryGirl.create(:user)
    b.genre = Genre.create(genre_name: "Mystery")
    b.save
    b
  end

  # Sleep is so created_at timestamps are guaranteed to be unique
  21.times do |i|
    let!("review#{i+1}".to_sym) do
      r = FactoryGirl.build(:review)
      r.user = FactoryGirl.create(:user)
      r.book = dynamic_book
      r.save
      r
    end
    sleep(1)
  end

  scenario 'scrolls to the bottom and does not see more than 20 reviews' do
    visit book_path(dynamic_book)

    expect(page).to have_content review1.title
    expect(page).to have_content review20.title
    expect(page).to_not have_content review21.title
  end

  scenario 'scrolls to the bottom and wants to see more than 20 reviews' do
    visit book_path(dynamic_book)
    click_link 'Next'
    
    expect(page).to have_content review21.title
  end
end
