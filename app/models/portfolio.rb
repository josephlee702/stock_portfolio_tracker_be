class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :assets, dependent: :destroy
  has_many :transactions, dependent: :destroy

  def total_market_value
    market_value = assets.sum { |asset| asset.market_price * asset.quantity }
    market_value.toFixed(2)
  end
end
