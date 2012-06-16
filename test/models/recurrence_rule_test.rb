require "minitest_helper"

describe RecurrenceRule do
  # fixtures :all

  before do
    @recurrence_rule = RecurrenceRule.new
  end

  it "must be valid" do
    @recurrence_rule.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
