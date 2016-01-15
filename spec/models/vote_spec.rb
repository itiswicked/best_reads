require 'rails_helper'

describe Vote do
  it "should have a vote attribute" do
    should have_valid(:vote).when('-1', '0', '1')
  end
  it "should not have a blank vote attribute" do
    should_not have_valid(:vote).when(nil, '', 'H')
  end
end
