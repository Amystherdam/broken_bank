
require "rails_helper"

RSpec.describe HomeController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/home").to route_to("home#index")
    end

    it "routes to #close_account" do
      expect(post: "/home/close-account").to route_to("home#close_account")
    end

    it "routes to #new_account" do
      expect(post: "/home/new-account").to route_to("home#new_account")
    end
  end
end
