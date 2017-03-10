class CreateUserOrganizationLink < ActiveRecord::Migration[5.0]
  def change
    create_table :b_good_users_organizations do |t|
      t.integer :b_good_user_id
      t.integer :organization_id
    end
  end
end
