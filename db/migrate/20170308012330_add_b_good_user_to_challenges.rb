class AddBGoodUserToChallenges < ActiveRecord::Migration[5.0]
  def change
    add_reference :challenges, :b_good_user, foreign_key: true
  end
end
