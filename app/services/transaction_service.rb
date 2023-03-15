class TransactionService
  def update_account_balance(account_transaction)

    bank_account = BankAccount.find(account_transaction.bank_account_id)

    case account_transaction.kind

    when "deposit"
      bank_account.account_balance += account_transaction.transaction_value
      bank_account.save!
    when "withdraw"
      bank_account.account_balance -= account_transaction.transaction_value
      bank_account.save!
    when "transfer"
      destination_bank_account = BankAccount.find_by(account_number: account_transaction.destination_bank_account)

      bank_account.account_balance -= account_transaction.transaction_value
      bank_account.save!

      destination_bank_account.account_balance += account_transaction.transaction_value
      destination_bank_account.save!
    end
  end

  def allow_transaction(account_transaction)  
    bank_account = BankAccount.find(account_transaction.bank_account_id)
    if account_transaction.kind != 'deposit'
      account_transaction.transaction_value <= bank_account.account_balance
    else
      true
    end
  end
end
