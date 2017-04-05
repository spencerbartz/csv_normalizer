class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :purchaser_id
      t.integer :item_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
