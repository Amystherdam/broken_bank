class AccountTransactionsController < ApplicationController
  before_action :set_account_transaction, only: %i[ show ]
  before_action :handle_submit, only: %i[ create ]

  # GET /account_transactions
  def index
    @account_transactions = AccountTransaction.all
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
    @account_transaction = AccountTransaction.new(account_transaction_params)

    if @account_transaction.save
      redirect_to @account_transaction, notice: "Account transaction was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_transaction
      @account_transaction = AccountTransaction.find(params[:id])
    end

    def handle_submit
      account_transaction_params["transaction_value"]&.delete!('.')
    end

    # Only allow a list of trusted parameters through.
    def account_transaction_params
      params.require(:account_transaction).permit(:transaction_value, :kind, :destination_bank_account, :bank_account_id, :client_id)
    end
end
