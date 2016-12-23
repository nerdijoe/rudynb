class ChangePasswordRequiredForUsers < ActiveRecord::Migration
  def change
    change_column_null :users, :true
  end
end
