class AddFireTimeToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :fire_at, :timestamp
  end
end
