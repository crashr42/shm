require 'spec_helper'

describe Diagnosis do
  it 'should be valid' do
    d = build(:diagnosis)
    d.should be_valid
  end

  it 'should be invalid' do
    d = build(:diagnosis, {
        :block_code => nil,
        :block_name => nil,
        :class_code => nil,
        :class_name => nil,
        :code       => nil,
        :code_name  => nil
    })
    d.should_not be_valid
    d.errors.should include(:block_code)
    d.errors.should include(:block_name)
    d.errors.should include(:class_code)
    d.errors.should include(:class_name)
    d.errors.should include(:code)
    d.errors.should include(:code_name)
  end
end
