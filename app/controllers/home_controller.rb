class HomeController < ApplicationController
  def index
    @account = BankAccount.where(client_id: current_client.id, status: :active).first
  end

  def close_account
    account = BankAccount.find(params[:account_id])
    account.status = :closed

    redirect_to home_path, notice: 'Account was successfully closed' if account.save
  end
  
  def new_account
    account_registration = AccountRegistrationService.new(current_client).create_bank_account

    redirect_to home_path, notice: 'Account was successfully opened' if account_registration
  end
end
