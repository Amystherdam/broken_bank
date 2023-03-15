class AccountRegistrationService
  def initialize(client)
    @client = client
  end

  def create_bank_account
    account_number = next_account_number
    BankAccount.create!(account_number:, client: @client)
  end

  private

  def next_account_number
    last_account_number = BankAccount.maximum(:account_number)

    if last_account_number.nil?
      "00000001"
    else
      next_account_number = last_account_number.to_i + 1
      sprintf("%08d", next_account_number)
    end
  end
end
