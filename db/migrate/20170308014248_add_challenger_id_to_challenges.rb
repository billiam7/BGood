class AddChallengerIdToChallenges < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :challenger_user_id, :integer
  end
end
