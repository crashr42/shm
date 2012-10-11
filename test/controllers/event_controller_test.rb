require "minitest_helper"

describe Cabinet::Manager::EventController do
  # fixtures :all

  describe "index action" do
    it "respond with success" do
      get :index
      must_respond_with :success
    end
  end
end

