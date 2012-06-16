require "minitest_helper"

describe Event do
  # fixtures :all

  before do
    @event = Event.new
  end

  it "must be valid" do
    @event.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
