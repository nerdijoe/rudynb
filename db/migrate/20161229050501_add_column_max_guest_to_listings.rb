class AddColumnMaxGuestToListings < ActiveRecord::Migration
  def change
    add_column :listings, :max_guests, :integer
  end
end
