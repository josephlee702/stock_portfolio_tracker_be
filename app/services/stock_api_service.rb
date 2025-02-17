require "faraday"
require "json"

class StockApiService
  def fetch_asset_price(symbol)
    api_key = Rails.application.credentials.alphavantage_api_key
    url = "https://www.alphavantage.co/query"

    params = {
      function: "GLOBAL_QUOTE",
      symbol: symbol,
      apikey: api_key
    }

    response = Faraday.get(url, params)

    if response.success?
      data = JSON.parse(response.body)
      asset = data.dig("Global Quote")

      if asset
        return { price: asset["05. price"].to_f.round(2) }
      else
        return { error: "Asset not found" }
      end
    else
      return { error: "Failed to fetch asset price" }
    end
  rescue StandardError => e
    return { error: "Failed to fetch asset price: #{e.message}" }
  end
end
