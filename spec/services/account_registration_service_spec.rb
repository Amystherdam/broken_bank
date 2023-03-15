require 'rails_helper'

RSpec.describe AccountRegistrationService do
  let(:client) {create(:client)}
  let(:account_registration) { AccountRegistrationService.new(client) }

  describe '#create_bank_account' do
    it 'should add one more in BankAccount' do
      expect do
        account_registration.create_bank_account
      end.to change(BankAccount, :count).by(1)
    end
  end
end
