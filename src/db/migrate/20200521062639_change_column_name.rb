class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :listings, :fire_at, :fire_x
  end
end
