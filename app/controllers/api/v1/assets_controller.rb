class Api::V1::AssetsController < ApplicationController
  def show
    asset = Asset.find_by(symbol: params[:symbol])

    if asset
      market_data = MarketDataService.new.fetch_asset_price(asset.symbol)
      render json: { asset: asset, market_price: market_data }, status: 202
    else
      render json: { error: "Asset Not Found" }, status: 404
    end
  end
end