class AddNameToPurchaser < ActiveRecord::Migration
  def change
    add_column :purchasers, :name, :string
  end
end
