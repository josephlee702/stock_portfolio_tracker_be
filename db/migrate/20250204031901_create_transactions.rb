class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :asset, null: false, foreign_key: true
      t.string :trade_type
      t.decimal :amount
      t.decimal :price
      t.datetime :executed_at

      t.timestamps
    end
  end
end
