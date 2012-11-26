class Item < ActiveRecord::Base
  attr_accessible :quantity, :product_id
  belongs_to :order



end
