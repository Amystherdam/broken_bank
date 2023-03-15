class BankAccount < ApplicationRecord
  belongs_to :client
  has_many :account_transactions

  enum status: { active: 0, closed: 1 }
end
