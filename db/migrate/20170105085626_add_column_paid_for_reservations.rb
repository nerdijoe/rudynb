class AddColumnPaidForReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :role, :boolean, :default => false, :null => false
  end
end
