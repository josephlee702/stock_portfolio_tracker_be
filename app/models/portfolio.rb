class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :assets, dependent: :destroy
  has_many :transactions, dependent: :destroy

  def total_market_value
    assets.sum { |asset| asset.market_price.to_f * asset.quantity.to_f }
  end
end
