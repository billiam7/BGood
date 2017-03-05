class Challenger < ActiveRecord::Migration[5.0]


      add_index(:challenges, [:user_id, :challenger_user_id])
      add_index(:challenges, [:challenger_user_id, :user_id])

  end
