require 'spec_helper'

describe IntegerParameter do
  it 'should be invalid with empty metadata' do
    p = build(:integer_parameter)
    p.should_not be_valid
  end

  context 'validate metadata' do
    it 'should be valid' do
      p = build(:integer_parameter, :metadata => {
          :default => 1,
          :validators => {
              :min => 1,
              :max => 5
          }
      })
      p.should be_valid
    end

    it 'should be invalid' do
      p = build(:integer_parameter, :metadata => {
          :default => nil,
          :validators => {
              :min => 'invalid',
              :max => 'invalid'
          }
      })
      p.should_not be_valid
      p.errors[:metadata].should include('parameter.integer.metadata.errors.default')
      p.errors[:metadata].should include('parameter.integer.metadata.errors.validators.min')
      p.errors[:metadata].should include('parameter.integer.metadata.errors.validators.max')
    end
  end

  context 'validate value' do
    before(:each) do
      @pr = build(:integer_parameter, :metadata => {
          :default => 1,
          :validators => {
              :min => 1,
              :max => 5
          }
      })
    end

    it 'should be valid' do
      @pr.validate_value(1).should eq(true)
      @pr.validate_value('1').should eq(true)
    end

    it 'should be invalid' do
      lambda { @pr.validate_value(Class) }.should raise_error(TypeError)
      lambda { @pr.validate_value(1.1) }.should raise_error(TypeError)
    end
  end

end
