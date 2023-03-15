class StatementController < ApplicationController
  def index
  end

  def statement_report
    start_date = Date.parse(params[:start_date]).beginning_of_day
    end_date = Date.parse(params[:end_date]).end_of_day
      
    @bank_account = BankAccount.where(client_id: current_client.id, status: :active).first
    @statement_report = AccountTransaction.where("created_at >= ? AND created_at <= ? AND client_id = ?", start_date, end_date, current_client.id)
    
    render 'statement/statement_report'
  end
end
