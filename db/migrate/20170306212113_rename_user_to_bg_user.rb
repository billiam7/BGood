class RenameUserToBgUser < ActiveRecord::Migration[5.0]
  def change
    rename_table :users, :b_good_users
  end
end
