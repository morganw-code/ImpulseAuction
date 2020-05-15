class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.references :user, foreign_key: true
      t.references :listing, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
