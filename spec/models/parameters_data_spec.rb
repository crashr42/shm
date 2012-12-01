require 'spec_helper'

describe ParametersData do
  it 'should be valid' do
    d = build(:parameters_data)
    d.should be_valid
  end
end
