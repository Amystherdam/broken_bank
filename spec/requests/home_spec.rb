require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let(:bank_account) {create(:bank_account)}

  before do
    client = create(:client)
    sign_in client
  end

  describe "GET /home" do
    it "returns http success" do
      get "/home"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /home/close-account" do
    it "should change account status for closed" do
      post "/home/close-account", params: { account_id: bank_account.id }
      bank_account.reload
      expect(bank_account.status).to eq("closed")
    end
  end

  describe "POST /home/new-account" do
    it "should add one more in BankAccount" do
      expect do
        post "/home/new-account"
      end.to change(BankAccount, :count).by(1)
    end
  end
end
