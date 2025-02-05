require "faraday"
require "json"

class MarketDataService
  BASE_URL = "https://pro-api.coinmarketcap.com"

  def initialize
    @conn = Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :url_encoded
      faraday.response :json, content_type: /\bjson$/
      faraday.adapter Faraday.default_adapter
    end
  end

  def fetch_asset_price(symbol)
    response = @conn.get("/v1/assets/#{symbol}") do |req|
      req.headers["Authorization"] = "Bearer #{ ENV["API_KEY"] }"
    end

    return JSON.parse(response.body) if response.success?

    { error: "Failed to fetch asset price" }
  end
end