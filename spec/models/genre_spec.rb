require 'rails_helper'

describe Genre do
  it "is a genre" do
    genre = Genre.new
    expect(genre).to be_a Genre
  end
end
