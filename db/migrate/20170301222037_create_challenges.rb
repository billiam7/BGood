class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.string :details
      t.date :date
      t.string :type
      t.boolean :completed
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
