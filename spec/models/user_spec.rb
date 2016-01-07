require 'rails_helper'

describe User do
  it "should have a first_name attribute" do
    should have_valid(:first_name).when('Foo')
  end
  it "should not have a blank first_name attribute" do
    should_not have_valid(:first_name).when(nil, '')
  end

  it "should have a last_name attribute" do
    should have_valid(:last_name).when('Bar')
  end
  it "should not have a blank last_name attribute" do
     should_not have_valid(:last_name).when(nil, '')
   end

end
