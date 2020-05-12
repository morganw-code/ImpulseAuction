class AddActiveToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :active, :integer
  end
end
