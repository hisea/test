class CreateSubscriptionPrices < ActiveRecord::Migration
  PRICES = [
    { price: 100, country_code: "US" },
    { price: 120, country_code: "CA"}
  ]

  class PriceImpt < ActiveRecord::Base
    self.table_name = "subscription_prices"
  end

  def up
    create_table :subscription_prices do |t|
      t.float :price
      t.integer :country_id

      t.timestamps null: false
    end

    add_foreign_key :subscription_prices, :countries

    PRICES.each do |price|
      country = Country.find_by(code: price[:country_code])
      PriceImpt.create(price: price[:price], country_id: country.id)
    end
  end

  def down
    drop_table :subscription_prices
  end
end
