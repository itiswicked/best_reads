require 'rails_helper'

feature "visitors can add books" do

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

  scenario "visitor adds new book successfully" do

    visit new_book_path
    expect(page).to have_content "New Book Form"

    fill_in 'Title', with: "The Monk"
    fill_in 'Author', with: "Matthew Lewis"
    fill_in 'Description', with: "A crazy monk goes on a sex crazed rampage."
    fill_in 'Year', with: "1796"
    select 'Satire', from: "Genres"


    click_button "Add Book"

    expect(page).to have_content "Book added successfully"
    expect(page).to have_content "The Monk"
  end

  scenario "visitor does not provide proper information for a book" do
    visit new_book_path

    click_button "Add Book"
    expect(page).to have_content "Book not created"
  end
end
