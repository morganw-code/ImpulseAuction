class AddColumnsToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :sold, :boolean
    add_column :listings, :relist, :boolean
  end
end
