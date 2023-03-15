
require "rails_helper"

RSpec.describe StatementController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/statement").to route_to("statement#index")
    end

    it "routes to #statement_report" do
      expect(post: "/statement/report").to route_to("statement#statement_report")
    end
  end
end
