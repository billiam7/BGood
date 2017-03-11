class RemoveOrganizationsAndBGoodUsersOrganization < ActiveRecord::Migration[5.0]
  def change
    drop_table :organizations
    drop_table :b_good_users_organizations
  end
end
