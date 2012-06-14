require "minitest_helper"

describe Patient do
  # fixtures :all

  before do
    @patient = Patient.new
  end

  it "must be valid" do
    @patient.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
