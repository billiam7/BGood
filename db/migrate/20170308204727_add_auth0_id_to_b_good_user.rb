class AddAuth0IdToBGoodUser < ActiveRecord::Migration[5.0]
  def change
    add_column :b_good_users, :auth0_id, :string
  end
end
