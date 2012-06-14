require "minitest_helper"

describe UsersToRoles do
  # fixtures :all

  before do
    @users_to_roles = UsersToRoles.new
  end

  it "must be valid" do
    @users_to_roles.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
