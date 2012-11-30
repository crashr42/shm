require 'spec_helper'

describe SelectParameter do
  it 'should be invalid with empty metadata' do
    p = build(:select_parameter)
    p.should_not be_valid
  end

  context 'validate metadata' do
    it 'should be valid' do
      p = build(:select_parameter, :metadata => {
          :default => nil,
          :values => %w(1 2 3)
      })
      p.should be_valid
    end

    it 'should be invalid metadata' do
      p = build(:select_parameter, :metadata => {
          :default => nil,
          :values => nil
      })
      p.should_not be_valid
      p.errors[:metadata].should include('parameter.select.metadata.errors.values')
    end
  end

  context 'validate value' do
    it 'should be valid' do
      p = build(:select_parameter, :metadata => {
          :default => 1,
          :values => %w(1 2 3 hello)
      })
      p.validate_value(1).should eq(true)
      p.validate_value('1').should eq(true)
      p.validate_value(:hello).should eq(true)
      p.validate_value('hello').should eq(true)
    end

    it 'should be invalid' do
      p = build(:select_parameter, :metadata => {
          :default => 1,
          :values => %w(1 2 3 hello)
      })
      p.validate_value(1.1).should eq(false)
      p.validate_value('invalid').should eq(false)
      p.validate_value(:invalid).should eq(false)
      p.validate_value(Class).should eq(false)
    end
  end
end
