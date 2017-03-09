class AddApiIdUniqToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_index :organizations, :api_id, unique: true
  end
end
