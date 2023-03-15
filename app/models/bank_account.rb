class BankAccount < ApplicationRecord
  belongs_to :client

  enum status: { active: 0, closed: 1 }
end
