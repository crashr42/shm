require "minitest_helper"

describe User do
  # fixtures :all

  before do
    @user = User.new
  end

  it "must be valid" do
    @user.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
