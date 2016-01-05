feature "visitors can add books" do
  scenario "visitor adds new book successfully" do

    visit new_book_path
    expect(page).to have_content "New Book Form"

    fill_in 'Title', with: "The Monk"
    fill_in 'Author', with: "Matthew Lewis"
    fill_in 'Description', with: "A crazy monk goes on a sex crazed rampage."
    fill_in 'Year', with: "1796"
    fill_in 'Genre', with: "Romance"

    click_button "Add Book"

    expect(page).to have_content "Book added successfully"
    expect(page).to have_content "The Monk"
    expect(page).to have_content "A crazy monk goes on a sex crazed rampage."
  end

  scenario "visitor does not provide proper information for a book" do
    visit new_book_path

    click_button "Add Book"
    expect(page).to have_content "Title can't be blank. Author can't be blank. Description can't be blank. Year can't be blank. Genre can't be blank."
  end
end
