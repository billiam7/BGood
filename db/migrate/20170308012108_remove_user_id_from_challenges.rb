class RemoveUserIdFromChallenges < ActiveRecord::Migration[5.0]
  def change
    remove_column :challenges, :user_id
  end
end
