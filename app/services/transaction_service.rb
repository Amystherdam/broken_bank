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
      current_time = Time.now
      transfer_rate = { common: 500, extraordinary: 700 }

      destination_bank_account = BankAccount.find_by(account_number: account_transaction.destination_bank_account)

      if current_time.hour >= 11 && current_time.hour <= 18 && is_business_day?(account_transaction.created_at)
        debit_amount = account_transaction.transaction_value + transfer_rate[:common] + calculate_additional_rate(account_transaction.transaction_value)
        bank_account.account_balance -= debit_amount
        
        bank_account.save!
      else
        debit_amount = account_transaction.transaction_value + transfer_rate[:extraordinary] + calculate_additional_rate(account_transaction.transaction_value)
        bank_account.account_balance -= debit_amount

        bank_account.save!
      end

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

  private

  def is_business_day?(date)
    (1..5).include?(date.wday)
  end

  def calculate_additional_rate(transaction_value)
    transaction_value > 100_000 ? 1000 : 0
  end
  
end
