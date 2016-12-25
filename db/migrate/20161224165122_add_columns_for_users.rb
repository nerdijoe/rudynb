class AddColumnsForUsers < ActiveRecord::Migration
  def change
      add_column :users, :profile_pic, :string
      add_column :users, :age, :integer
  end
end
