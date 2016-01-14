require 'rails_helper'

describe Book do
  let!(:book_1) { FactoryGirl.create(:book, title: "The Monk") }
  let!(:book_2) { FactoryGirl.create(:book, title: "The Cat in the Hat") }
  let!(:book_3) { FactoryGirl.create(:book, title: "To Kill a Mocking Bird") }
  let!(:book_4) { FactoryGirl.create(:book, title: "Jane Eyre") }

  it "should contain a title attribute" do
    should have_valid(:title).when("The Da Vinci Code")
  end
  it "should contain a description attribute" do
    should have_valid(:description).when("Some crazy stuff happened after the death of a museum curator ")
  end
  it "should contain a year attribute" do
    should have_valid(:year).when(2003)
  end

  describe "#search_by_book_name" do
    it "retrieves the title 'The Monk'" do
      results = Book.search_by_book_name("The")

      expect(results).to include book_1
      expect(results).to include book_2
      expect(results).to_not include book_3
    end
  end
end
