class Api::V1::AssetsController < ApplicationController
  before_action :authenticate_user
  before_action :set_portfolio
  before_action :set_asset, only: [:show, :update, :destroy]

  def index
    require 'pry'; binding.pry
    assets = @portfolio.assets
    render json: assets
  end

  def show
    render json: @asset
  end

  def create
    #using .build automatically associates the asset with the portfolio (child with the parent)
    asset = @portfolio.assets.build(asset_params)

    market_data = MarketDataService.new.fetch_asset_price(asset.symbol)

    if market_data.is_a?(Hash) && market_data[:error]
      render json: { message: "Asset was not found." }, status: 422
    else
      asset.update(market_price: market_data[:price]) if market_data[:price]
    end

    if asset.save
      render json: asset, status: 201
    else
      render json: asset.errors, status: 422
    end
  end

  def update
    if @asset.update(asset_params)
      render json: @asset
    else
      render json: @asset.errors, status: 422
    end
  end

  def destroy
    @asset.destroy
    render json: { message: "Asset was deleted successfully." }, status: 202
  end

  private

  def set_portfolio
    @portfolio = @current_user.portfolios.find_by(id: params[:portfolio_id])
    render json: { error: "Portfolio not found." }, status: 404 unless @portfolio
  end

  def set_asset
    @asset = @portfolio.assets.find_by(id: params[:id])
    render json: { error: "Asset not Found." }, status: 404 unless @asset
  end

  def asset_params
    params.require(:asset).permit(:symbol, :name, :quantity, :asset_type)
  end
end