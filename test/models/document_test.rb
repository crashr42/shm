require "minitest_helper"

describe Document do
  # fixtures :all

  before do
    @document = Document.new
  end

  it "must be valid" do
    @document.must_be :valid?
  end

  it "must be a real test" do
    flunk "Need real tests"
  end
end
