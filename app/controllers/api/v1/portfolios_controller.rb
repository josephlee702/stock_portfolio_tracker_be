class Api::V1::PortfoliosController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_portfolio, only: [:show, :update, :destroy]

  def index
    require 'pry'; binding.pry
    if current_user
      render json: current_user.portfolios.as_json(methods: :total_market_value), status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def show
    @portfolio.assets.each do |asset|
      if asset.asset_type == "crypto"
        market_data = MarketDataService.fetch_price(asset.symbol, asset.asset_type)
      else
        market_data = MarketDataService.fetch_price(asset.symbol, asset.asset_type)
      end
    end

    render json: @portfolio.as_json(methods: :total_market_value), status: 200
  end

  def create
    portfolio = Portfolio.new(portfolio_params)

    if portfolio.save
      render json: portfolio, status: 201
    else
      render json: { error: portfolio.errors.full_messages }, status: 402
    end
  end

  def update
    if @portfolio.update(portfolio_params)
      render json: @portfolio, status: 200
    else
      render json: { error: @portfolio.errors.full_messages }, status: 402
    end
  end

  def destroy
    @portfolio.destroy
    render json: { message: "Portfolio was deleted successfully." }, status: 200
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:name, :user_id)
  end
  
  #designates portfolio to perform show, update and destroy actions on
  def set_portfolio
    @portfolio = Portfolio.find_by(id: params[:id])
    render json: { error: "Portfolio not found." }, status: 404 unless @portfolio
  end
end