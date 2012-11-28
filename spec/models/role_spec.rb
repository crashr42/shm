require 'spec_helper'

describe Role do
  it 'should be valid' do
    r = Role.new
    r.name = 'some role'
    r.should be_valid
  end

  it 'should be not valid' do
    r = Role.new
    r.should_not be_valid
  end
end
