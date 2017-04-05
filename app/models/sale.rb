class Sale < ActiveRecord::Base
  validates_presence_of :merchant_id
  validates_presence_of :item_id
end
