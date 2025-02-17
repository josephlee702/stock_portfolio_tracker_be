require "faraday"
require "json"

class CryptoApiService

  def fetch_asset_price(symbol)
    api_key = Rails.application.credentials.coinmarketcap_api_key
    url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=#{symbol}&convert=USD"

    response = Faraday.get(url) do |req|
      req.headers["X-CMC_PRO_API_KEY"] = api_key
      req.headers["Accept"] = "application/json"
    end

    if response.success?
      data = JSON.parse(response.body)
      asset = data.dig("data", symbol.upcase)
      
      if asset
        return { price: asset["quote"]["USD"]["price"].round(2) }
      else
        return { error: "Asset not found" }
      end
    else
      return { error: "Failed to fetch asset price" }
    end
  rescue StandardError => e
    return { error: "Failed to fetch asset price" }
  end
end
