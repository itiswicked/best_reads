require 'rails_helper'

describe Author do
  it "should have a name attribute" do
    should have_valid(:name).when('Dan Brown')
  end

  it "should not be left blank" do
   should_not have_valid(:name).when(nil, '')
 end
end
