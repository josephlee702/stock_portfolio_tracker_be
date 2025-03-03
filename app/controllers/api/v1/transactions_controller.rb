class Api::V1::TransactionsController < ApplicationController
  # before_action :authenticate_user
  before_action :set_portfolio
  before_action :set_transaction, only: [:show, :update, :destroy]

  def index
    transactions = @portfolio.transactions
    render json: transactions, status: 200
  end

  def show
    render json: @transaction, status: 200
  end

  def create
    transaction = @portfolio.transactions.build(transaction_params)

    if transaction.save
      render json: transaction, status: 201
    else
      render json: { errors: transaction.errors.full_messages }, status: 422
    end
  end

  def update
    if @transaction.update(transaction_params)
      render json: @transaction, status: 200
    else
      render json: { errors: @transactions.errors.full_messages }, status: 422
    end
  end

  def destroy
    @transaction.destroy
    render json: { message: "Transaction was deleted successfully." }, status: 200
  end

  private

  def set_portfolio
    @portfolio = current_user.portfolios.find_by(id: params[:portfolio_id])
    render json: { error: "Portfolio was not found." }, status: 404 unless @portfolio
  end

  def set_transaction
    @transaction = @portfolio.transactions.find_by(id: params[:id])
    render json: { error: "Transaction was not found." }, status: 404 unless @transaction
  end

  def transaction_params
    params.require(:transaction).permit(:asset_id, :trade_type, :amount, :price, :executed_at)
  end
end
