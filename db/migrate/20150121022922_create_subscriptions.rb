class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.float :amount_paid
      t.integer :currency_country_id
      t.timestamp :activated_at
      t.timestamp :cancelled_at, default: nil

      t.timestamps null: false
    end
    add_foreign_key :subscriptions, :users
    add_foreign_key :subscriptions, :countries, column: :currency_country_id
  end
end
