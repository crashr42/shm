require 'spec_helper'

describe Parameter do
  it 'should be valid' do
    p = build(:parameter)
    p.should be_valid
  end
end
