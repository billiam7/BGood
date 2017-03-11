class AddOpportunityToChallenge < ActiveRecord::Migration[5.0]
  def change
    add_reference :challenges, :opportunity, foreign_key: true
  end
end
