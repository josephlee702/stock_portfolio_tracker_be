class AddAssetTypeToAssets < ActiveRecord::Migration[7.1]
  def change
    add_column :assets, :asset_type, :string
  end
end
