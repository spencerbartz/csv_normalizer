class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :merchant_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
