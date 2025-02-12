class Asset < ApplicationRecord
  belongs_to :portfolio
  has_many :transactions, dependent: :destroy

  validates :symbol, presence: true
  validates :name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  #we allow nil here just in case market_price isn't available
  validates :market_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
