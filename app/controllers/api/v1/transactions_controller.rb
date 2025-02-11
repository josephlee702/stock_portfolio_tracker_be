class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate_user
  before_action :set_portfolio
  before_action :set_transaction, only: [:show, :update, :destroy]

  def index

  end

  def show

  end

  def create

  end

  def update

  end

  def destroy

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
    params.require(:transaction).permite(:asset_id, :transaction_type, :quantity, :price, :executed_at)
  end
end
