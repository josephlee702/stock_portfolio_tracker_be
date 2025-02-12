class AddMarketPriceToAssets < ActiveRecord::Migration[7.1]
  def change
    add_column :assets, :market_price, :decimal
  end
end
