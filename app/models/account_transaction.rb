class AccountTransaction < ApplicationRecord
  belongs_to :bank_account
  belongs_to :client

  enum kind: { deposit: 0, withdraw: 1, transfer: 2 }

  validates_presence_of :transaction_value, :kind, :bank_account, :client
end
