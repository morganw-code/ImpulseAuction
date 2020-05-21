class ChangeColumnNameFix < ActiveRecord::Migration[5.2]
  def change
    rename_column :listings, :fire_x, :fire_at
  end
end
