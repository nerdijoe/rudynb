class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.string :description
      t.string :address
      t.string :country
      t.string :phone

      t.integer :num_bedrooms
      t.integer :price
      t.string :currency

      t.string :house_rules


      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
