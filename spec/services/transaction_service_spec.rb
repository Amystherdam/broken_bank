require 'rails_helper'

RSpec.describe TransactionService do
  before do
    client = create(:client)
    @bank_account = create(:bank_account, client:)
    @account_transaction = create(:account_transaction, bank_account: @bank_account, client:, password_confirmation: '12345678')
    @account_high_transaction = create(
      :account_transaction, 
      kind: :transfer,
      bank_account: @bank_account, 
      transaction_value: 1_000_000, 
      password_confirmation: '12345678'
    )
  end

  let(:transaction_service) { TransactionService.new }

  describe '#update_account_balance' do
    context 'Should change BankAccount object' do
      it 'Should change account_balance after creation' do
        expect { transaction_service.update_account_balance(@account_transaction)

          @bank_account.reload
        }.to change { @bank_account.account_balance }.by( @bank_account.account_balance + @account_transaction.transaction_value )
      end
    end
  end

  describe '#allow_transaction' do
    it 'transaction value <= balance' do
      expect(transaction_service.allow_transaction(@account_transaction)).to be_truthy
    end
    
    it 'transaction value > balance for tranfer' do
      expect(transaction_service.allow_transaction(@account_high_transaction)).to be_falsy
    end
  end
end
