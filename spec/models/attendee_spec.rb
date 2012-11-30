require 'spec_helper'

describe Attendee do
  it 'should be valid' do
    a = build(:attendee)
    a.should be_valid
  end

  it 'should not be valid' do
    a = build(:attendee, :user => nil)
    a.should_not be_valid
    a.errors.should include(:user_id)

    a = build(:attendee, :event => nil)
    a.should_not be_valid
    a.errors.should include(:event_id)
  end
end
