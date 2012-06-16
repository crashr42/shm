require "minitest_helper"

describe Manager do
  # fixtures :all

  before do
    @manager = Manager.new
  end

  it "must be valid" do
    @manager.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
