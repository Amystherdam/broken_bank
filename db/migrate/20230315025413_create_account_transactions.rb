class CreateAccountTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :account_transactions do |t|
      t.integer :transaction_value, null: false, default: 0
      t.integer :kind, null: false, default: 0
      t.string :destination_bank_account, null: true
      t.references :bank_account, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
