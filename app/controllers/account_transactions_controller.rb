class AccountTransactionsController < ApplicationController
  before_action :set_account_transaction, only: %i[ show ]
  before_action :set_kinds, only: %i[ new create ]
  before_action :inject_dependencies, only: %i[create]

  # GET /account_transactions
  def index
    @account_transactions = AccountTransaction.where(client_id: current_client.id, bank_account_id: current_client.bank_accounts.active.first.id)
  end

  # GET /account_transactions/1
  def show
  end

  # GET /account_transactions/new
  def new
    @account_transaction = AccountTransaction.new
  end

  # GET /account_transactions/1/edit
  def edit
  end

  # POST /account_transactions
  def create
    @account_transaction = AccountTransaction.new(handle_submit(account_transaction_params))


    if @account_transaction.save
      @transaction_service.update_account_balance(@account_transaction)

      redirect_to @account_transaction, notice: "Account transaction was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def set_account_transaction
      @account_transaction = AccountTransaction.find(params[:id])
    end

    def set_kinds
      @kinds = AccountTransaction.kinds.keys
    end

    def inject_dependencies
      @transaction_service = TransactionService.new
    end

    def handle_submit(account_transaction_params)
      bank_account = BankAccount.where(client_id: current_client.id, status: :active).first
      account_transaction_params["transaction_value"]&.delete!('.')
      account_transaction_params = account_transaction_params.merge(
        {
          "bank_account_id" =>  bank_account.id,
          "client_id" => current_client.id
        }
      )
    end

    # Only allow a list of trusted parameters through.
    def account_transaction_params
      params.require(:account_transaction).permit(:transaction_value, :kind, :destination_bank_account, :password_confirmation)
    end
end
