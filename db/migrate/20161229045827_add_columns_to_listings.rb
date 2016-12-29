class AddColumnsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :city, :string
    add_column :listings, :country_code, :string
  end
end
