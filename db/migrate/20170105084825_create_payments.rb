class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :transaction_id
      t.decimal :amount
      t.string :card_type
      t.string :cardholder_name
      t.string :billing_address
      t.string :billing_postal_code

      t.references :reservation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
