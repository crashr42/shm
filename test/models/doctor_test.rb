require "minitest_helper"

describe Doctor do
  # fixtures :all

  before do
    @doctor = Doctor.new
  end

  it "must be valid" do
    @doctor.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
