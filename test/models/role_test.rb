require "minitest_helper"

describe Role do
  # fixtures :all

  before do
    @role = Role.new
  end

  it "must be valid" do
    @role.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
