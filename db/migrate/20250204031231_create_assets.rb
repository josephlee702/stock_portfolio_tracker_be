class CreateAssets < ActiveRecord::Migration[7.1]
  def change
    create_table :assets do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.string :symbol
      t.string :name
      t.decimal :quantity

      t.timestamps
    end
  end
end
