class AddDeviseTokenAuthToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table(:users) do |t|
      ## Required
      t.string :provider, null: false, default: "email"
      t.string :uid, null: false, default: ""

      ## Trackable (optional)
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      ## Tokens
      t.text :tokens
    end

    add_index :users, [:uid, :provider], unique: true
  end
end
