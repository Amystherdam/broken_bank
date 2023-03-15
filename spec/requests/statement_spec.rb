require 'rails_helper'

RSpec.describe "Statements", type: :request do

  before do
    client = create(:client)
    create(:bank_account, client:)

    sign_in client
  end

  describe "GET /index" do
    it "returns http success" do
      get "/statement"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /statement-report" do
    it "returns http success" do
      post "/statement/report", params: { start_date: '05-02-2023', end_date: '05-12-2023' }
      expect(response).to have_http_status(:success)
    end
  end

end
