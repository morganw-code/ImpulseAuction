class AddColumnsToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :sold, :integer
    add_column :listings, :relist, :integer
  end
end
