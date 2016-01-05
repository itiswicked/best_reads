require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:first_name).when('Foo') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:first_name).when('Bar') }
  it { should_not have_valid(:first_name).when(nil, '') }

end
