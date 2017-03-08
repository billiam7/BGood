class RemoveChallengerUserIdFromChallenges < ActiveRecord::Migration[5.0]
  def change
    remove_column :challenges, :challenger_user_id
  end
end
