class Merchant < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_presence_of   :address
  validates_uniqueness_of :address
end
