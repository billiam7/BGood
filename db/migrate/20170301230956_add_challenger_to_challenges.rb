class AddChallengerToChallenges < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :challenger_id, :integer
  end
end
