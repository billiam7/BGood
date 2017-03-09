class AddRefererIdToBGoodUser < ActiveRecord::Migration[5.0]
  def change
    add_column :b_good_users, :referer, :integer
  end
end
