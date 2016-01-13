require 'rails_helper'

feature "users can add books" do

  before(:each) do
    Genre.create(genre_name: "Comedy")
    Genre.create(genre_name: "Drama")
    Genre.create(genre_name: "Non-Fiction")
    Genre.create(genre_name: "Realistic Fiction")
    Genre.create(genre_name: "Romance Novel")
    Genre.create(genre_name: "Satire")
    Genre.create(genre_name: "Tragedy")
    Genre.create(genre_name: "TragiComedy")
  end

  let!(:author) do
    Author.new(name: "Matthew Lewis")
  end

  let!(:book_1) do
    FactoryGirl.create(
      :book,
      id: '1',
      title: "The Monk",
      author: author,
      description: "A crazy monk goes on a sex crazed rampage. Sells soul to satan",
      year: "1796",
      genre_id: "5"
    )
  end

  scenario "user updates book successfully" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit edit_book_path(book_1)
    expect(page).to have_content "Edit"

    fill_in 'Title', with: "The Monk"
    fill_in 'Author', with: "Matthew Lewis"
    fill_in 'Description', with: "A crazy monk sells soul to satan"
    fill_in 'Year', with: "1796"
    select 'Satire', from: "Genres"

    click_button "Edit Book"

    expect(page).to have_content "The Monk"
    expect(page).to have_content user.first_name
  end

end
