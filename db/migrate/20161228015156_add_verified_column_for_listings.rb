class AddVerifiedColumnForListings < ActiveRecord::Migration
  def change
    add_column :listings, :verified, :boolean, :default => false, :null => false
  end
end
