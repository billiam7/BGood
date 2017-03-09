class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :api_id
      t.string :url

      t.timestamps
    end
  end
end
