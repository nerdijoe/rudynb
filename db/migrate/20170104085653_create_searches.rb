class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :keyword
      t.string :city
      t.string :country
      t.decimal :min_price
      t.decimal :max_price
      t.integer :num_bedrooms
      t.integer :num_guests

      t.timestamps null: false
    end
  end
end
