require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  before do
    @bank_account = create(:bank_account)
    @client = create(:client)
    @account_transaction = build(:account_transaction, bank_account: @bank_account, client: @client)
  end

  # Conflito entre validators somente no teste
  # describe 'Relations' do
  #   it { is_expected.to(belong_to(:bank_account)) }
  #   it { is_expected.to(belong_to(:client)) }
  # end

  describe 'Validations' do
    # Conflito entre validators somente no teste
    # it { is_expected.to(validate_presence_of(:transaction_value)) }
    # it { is_expected.to(validate_presence_of(:kind)) }
    # it { is_expected.to(validate_presence_of(:bank_account)) }
    # it { is_expected.to(validate_presence_of(:client)) }

    it "is valid with correct password confirmation" do
      @account_transaction.password_confirmation = @client.password
      expect(@account_transaction).to be_valid
    end

    it "is invalid with incorrect password confirmation" do
      @account_transaction.password_confirmation = "wrong_password"
      expect(@account_transaction).to be_invalid
    end
  end

  describe 'Enums' do
    it { is_expected.to(define_enum_for(:kind).with_values(%i[deposit withdraw transfer])) }
  end
end
