class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to, :user
      t.belongs_to, :listing
      t.date, :start_date
      t.date, :end_date
      t.integer :num_guests

      t.timestamps null: false
    end
  end
end
