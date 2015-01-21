class CreateCountry < ActiveRecord::Migration
  COUNTRY_DATA = [
    { name: "Canada", code: "CA", currency: "CAD" },
    { name: "United States", code: "US", currency: "USD"}
  ]

  class CountryImpt < ActiveRecord::Base
    self.table_name = "countries"
  end

  def up
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.string :currency
    end

    #TODO If More time is give, will set up a data import infrustructure such as an yaml data loader.
    COUNTRY_DATA.each do |country|
      CountryImpt.create(country)
    end
  end

  def down
    drop_table :countries
  end
end
