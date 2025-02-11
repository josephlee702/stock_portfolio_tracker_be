class AddPortfolioToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_reference :transactions, :portfolio, null: false, foreign_key: true
  end
end
