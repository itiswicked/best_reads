require 'rails_helper'

describe Author do
  it { should have_valid(:name).when('Foo') }
  it { should_not have_valid(:name).when(nil, '') }

end
