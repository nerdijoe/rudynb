class RenameColumnInReservations < ActiveRecord::Migration
  def change
    rename_column :reservations, :role, :paid
  end
end
