require 'rails_helper'

describe Book do
  it "should contain a title attribute" do
    should have_valid(:title).when("The Da Vinci Code")
  end
  it "should contain a description attribute" do
    should have_valid(:description).when("Some crazy stuff happened after the death of a museum curator ")
  end
  it "should contain a year attribute" do
    should have_valid(:year).when(2003)
  end

end
