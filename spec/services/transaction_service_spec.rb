require 'rails_helper'

RSpec.describe TransactionService do
  before do
    client = create(:client)
    client_tranfer = create(:client)
    other_client = create(:client)

    @bank_account = create(:bank_account, client:, account_balance: 120_000)
    @bank_account_tranfer = create(:bank_account, client: client_tranfer, account_balance: 120_000)
    @other_bank_account = create(:bank_account, client: other_client, account_balance: 120_000)

    @account_transaction_plus = create(
      :account_transaction, 
      transaction_value: 100_000, 
      bank_account: @bank_account, 
      client:,
      password_confirmation: '12345678'
    )

    @account_transaction_minus = create(
      :account_transaction, 
      kind: :withdraw,
      transaction_value: 10_000, 
      bank_account: @bank_account, 
      client:, 
      password_confirmation: '12345678'
    )

    @account_transaction_transfer = create(
      :account_transaction, 
      kind: :transfer,
      transaction_value: 10_000, 
      destination_bank_account: @other_bank_account.account_number,
      bank_account: @bank_account_tranfer, 
      client: client_tranfer,
      password_confirmation: '12345678'
    )

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
      it 'Should change account_balance after creation in plus value' do
        expect { transaction_service.update_account_balance(@account_transaction_plus)
          @bank_account.reload
        }.to change { @bank_account.account_balance }.by( @account_transaction_plus.transaction_value )
      end

      it 'Should change account_balance after creation in minus value' do
        expect { transaction_service.update_account_balance(@account_transaction_minus)
          @bank_account.reload

        }.to change { @bank_account.account_balance }.by( -@account_transaction_minus.transaction_value )
      end

      it 'Should change account_balance after creation in minus value' do
        transaction_service.update_account_balance(@account_transaction_transfer)
        account_balance = @bank_account_tranfer.account_balance
        @bank_account_tranfer.reload
        expect(@bank_account_tranfer.account_balance).to eq(account_balance - (@account_transaction_transfer.transaction_value + 500))
      end
    end
  end

  describe '#allow_transaction' do
    it 'transaction value <= balance' do
      expect(transaction_service.allow_transaction(@account_transaction_plus)).to be_truthy
    end
    
    it 'transaction value > balance for tranfer' do
      expect(transaction_service.allow_transaction(@account_high_transaction)).to be_falsy
    end
  end
end
