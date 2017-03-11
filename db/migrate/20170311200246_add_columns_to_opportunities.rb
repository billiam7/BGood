class AddColumnsToOpportunities < ActiveRecord::Migration[5.0]
  def change
    add_column :opportunities, :organization, :string
    add_column :opportunities, :date, :date
    add_column :opportunities, :time, :time
    add_column :opportunities, :link, :string
  end
end
