require 'rails_helper'

feature "users can search books" do

  let!(:book_1) { FactoryGirl.create(:book, title: "The Monk") }
  let!(:book_2) { FactoryGirl.create(:book, title: "The Cat in the Hat") }
  let!(:book_3) { FactoryGirl.create(:book, title: "To Kill a Mocking Bird") }
  let!(:book_4) { FactoryGirl.create(:book, title: "Jane Eyre") }

  scenario "user searches books successfully" do
    visit root_path

    fill_in "query", with: "The"
    click_button "Search"

    expect(page).to have_content "The Monk"
    expect(page).to have_content "The Cat in the Hat"
    expect(page).to_not have_content "Jane Eyre"
    expect(page).to_not have_content "To Kill a Mocking Bird"

  end
end
