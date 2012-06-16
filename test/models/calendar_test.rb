require "minitest_helper"

describe Calendar do
  # fixtures :all

  before do
    @calendar = Calendar.new
  end

  it "must be valid" do
    @calendar.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
