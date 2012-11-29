require 'spec_helper'

describe BoolParameter do
  context 'validate metadata' do
    it 'should be valid' do
      p = build(:bool_parameter, :metadata => {
          :values => %w(true false),
          :default => 'false'
      })
      p.should be_valid
    end

    it 'should be invalid' do
      p = build(:bool_parameter, :metadata => {
          :values => '',
          :default => ''
      })
      p.should_not be_valid
      p.errors[:metadata].should include('parameter.bool.metadata.errors.default')
      p.errors[:metadata].should include('parameter.bool.metadata.errors.values')
    end
  end

  context 'validate value' do
    before(:each) do
      @pr = build(:bool_parameter)
    end

    it 'should be valid' do
      @pr.validate_value(true).should eq(true)
      @pr.validate_value(false).should eq(true)
      @pr.validate_value('true').should eq(true)
      @pr.validate_value('false').should eq(true)
    end

    it 'should be not valid' do
      @pr.validate_value(Class).should eq(false)
      @pr.validate_value(123).should eq(false)
    end
  end
end
