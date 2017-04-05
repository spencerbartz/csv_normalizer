class CreatePurchasers < ActiveRecord::Migration
  def change
    create_table :purchasers do |t|

      t.timestamps null: false
    end
  end
end
