class Challenged < ActiveRecord::Migration[5.0]
  def change
    add_column :challenges, :challenger_user_id, :integer
    add_column :challenges, :user_id, :integer
  end
  #   add_index(:challenges, [:user_id, :challenger_user_id])
  #   add_index(:challenges, [:challenger_user_id, :user_id])
  # end
end
