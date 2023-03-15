class AddStatusToBankAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :bank_accounts, :status, :integer, null: false, default: 0
  end
end
