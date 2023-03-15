FactoryBot.define do
  factory :account_transaction do
    transaction_value { 1000 }
    kind { :deposit }
    destination_bank_account { nil }
    bank_account
    client
  end
end
