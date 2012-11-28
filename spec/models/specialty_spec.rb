require 'spec_helper'

describe Specialty do
  it 'should be valid' do
    s = Specialty.new
    s.name = 'some specialty'
    s.should be_valid
  end

  it 'should be not valid' do
    s = Specialty.new
    s.should_not be_valid
  end
end
