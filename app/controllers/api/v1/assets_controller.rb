class Api::V1::AssetsController < ApplicationController
  before_action :authenticate_user
  before_action :set_portfolio
  before_action :set_asset, only: [:show, :update, :destroy]

  def index
    assets = @portfolio.assets
    render json: assets
  end

  def show
    render json: @asset
  end

  def create
    #using .build automatically associates the asset with the portfolio (child with the parent)
    asset = @portfolio.assets.build(asset_params)

    if asset.asset_type == "crypto"
      market_data = CryptoApiService.new.fetch_asset_price(asset.symbol)
    else
      market_data = StockApiService.new.fetch_asset_price(asset.symbol)
    end

    if market_data[:error] == "Asset not found"
      return render json: { errors: "Asset was not found. Please input a valid symbol for your asset." }, status: 422
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
    if @asset.destroy
      render json: { message: "Asset was deleted successfully." }, status: 202
    else
      render json: { error: "Asset was not deleted successfully." }, status: 422
    end
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