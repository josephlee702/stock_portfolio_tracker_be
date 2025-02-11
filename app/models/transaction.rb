class Transaction < ApplicationRecord
  belongs_to :asset
  belongs_to :portfolio
end
