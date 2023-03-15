class AccountTransaction < ApplicationRecord
  belongs_to :bank_account
  belongs_to :client

  attr_accessor :password_confirmation

  enum kind: { deposit: 0, withdraw: 1, transfer: 2 }

  validates_presence_of :transaction_value, :kind, :bank_account, :client

  validate :correct_password_confirmation

  def correct_password_confirmation
    unless self.client.valid_password?(password_confirmation)
      errors.add(:password_confirmation, "Invalid password")
    end
  end
end
