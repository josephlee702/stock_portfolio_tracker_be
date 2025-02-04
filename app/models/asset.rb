class Asset < ApplicationRecord
  belongs_to :portfolio
  has_many :transactions, dependent: :destroy
end
