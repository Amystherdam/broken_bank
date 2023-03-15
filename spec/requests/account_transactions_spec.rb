require 'rails_helper'

RSpec.describe "/account_transactions", type: :request do
  let(:valid_attributes) do
    {
      transaction_value: "1000",
      kind: :deposit,
      password_confirmation: "12345678"
    }
  end

  let(:invalid_attributes) do
    {
      transaction_value: nil,
      kind: nil
    }
  end

  before do
    client = create(:client)
    bank_account = create(:bank_account, client:)
    @account_transaction = create(:account_transaction, bank_account:, client:, password_confirmation: '12345678')

    sign_in client
  end

  describe "GET /index" do
    it "renders a successful response" do
      get account_transactions_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get account_transaction_url(@account_transaction)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_account_transaction_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new AccountTransaction" do
        expect {
          post account_transactions_url, params: { account_transaction: valid_attributes }
        }.to change(AccountTransaction, :count).by(1)
      end

      it "redirects to the created account_transaction" do
        post account_transactions_url, params: { account_transaction: valid_attributes }
        expect(response).to redirect_to(account_transaction_url(AccountTransaction.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new AccountTransaction" do
        expect {
          post account_transactions_url, params: { account_transaction: invalid_attributes }
        }.to change(AccountTransaction, :count).by(0)
      end


      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post account_transactions_url, params: { account_transaction: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end
end
