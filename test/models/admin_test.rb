require "minitest_helper"

describe Admin do
  # fixtures :all

  before do
    @admin = Admin.new
  end

  it "must be valid" do
    @admin.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
