class Purchase < ActiveRecord::Base
  validates_presence_of   :purchaser_id
  validates_presence_of   :item_id
  validates_presence_of   :quantity
end
