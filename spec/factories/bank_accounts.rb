FactoryBot.define do
  factory :bank_account do
    account_number { "00000000" }
    account_balance { 0 }
    client
  end
end
