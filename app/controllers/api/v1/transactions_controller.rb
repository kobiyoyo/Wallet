class Api::V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[update destroy]
  before_action :authorize_admin, only: %i[destroy index update]

  # GET /transactions
  def index
    @transactions = Transaction.all
    render json: @transactions
  end

  # POST /transactions
  def create
    @transaction_params = Transaction.new(transaction_params)
    transaction_action = CheckTransaction.new
    if transaction_action.action(@transaction_params, @current_user)
      render json: transaction_action.action(@transaction_params, @current_user)
    else
      render json: @transaction_params.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(admin_approve_transaction_params)
      approve_transaction = ApproveTransaction.new
      approve_transaction.create(@transaction)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def transaction_params
    params.permit(:transaction_type, :description, :amount, :status, :confirm, :user_id, :wallet_id, :currency_id)
  end

  # Only allow a trusted parameter "white list" through.
  def admin_approve_transaction_params
    params.permit(:confirm)
  end
end
