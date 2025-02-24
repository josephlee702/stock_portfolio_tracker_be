require "faraday"
require "json"

class MarketDataService
  def self.fetch_price(symbol, asset_type)
    if asset_type == "crypto"
      result = fetch_crypto_price(symbol)
    else
      result = fetch_stock_price(symbol)
    end

    if result[:price] == nil
      alt_result = asset_type == "crypto" ? fetch_stock_price(symbol) : fetch_crypto_price(symbol)
      return alt_result[:price] || 0
    end

    result[:price] || 0
  end

  private

  def self.fetch_crypto_price(symbol)
    response = Faraday.get("https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest", 
      { symbol: symbol, convert: "USD" }, 
      { "X-CMC_PRO_API_KEY" => Rails.application.credentials.coinmarketcap_api_key })

    json = JSON.parse(response.body)
    
    if json["data"] && json["data"][symbol]
      { price: json["data"][symbol]["quote"]["USD"]["price"] }
    else
      { error: "Crypto not found" }
    end
  end

  def self.fetch_stock_price(symbol)
    response = Faraday.get("https://www.alphavantage.co/query", 
      { function: "GLOBAL_QUOTE", symbol: symbol, apikey: Rails.application.credentials.alphavantage_api_key })

    json = JSON.parse(response.body)
    
    if json["Global Quote"] && json["Global Quote"]["05. price"]
      { price: json["Global Quote"]["05. price"].to_f }
    else
      { error: "Stock not found" }
    end
  end
end