class AddAdditionalPropertyToUser < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :country_id, :integer

    add_foreign_key :users, :countries
  end
end
