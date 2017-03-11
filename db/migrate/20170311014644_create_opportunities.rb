class CreateOpportunities < ActiveRecord::Migration[5.0]
  def change
    create_table :opportunities do |t|
      t.string :api_id
      t.string :name

      t.timestamps
    end
  end
end
