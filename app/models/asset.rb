class Asset < ApplicationRecord
  belongs_to :portfolio
  has_many :transactions, dependent: :destroy

  validates :symbol, presence: true
  validates :name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :market_price, numericality: { greater_than_or_equal_to: 0 }
end
