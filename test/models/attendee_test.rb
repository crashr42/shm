require "minitest_helper"

describe Attendee do
  # fixtures :all

  before do
    @attendee = Attendee.new
  end

  it "must be valid" do
    @attendee.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
