class ChangeTypeToChallengeTypeInChallenges < ActiveRecord::Migration[5.0]
  def change
    rename_column :challenges, :type, :challenge_type
  end
end
