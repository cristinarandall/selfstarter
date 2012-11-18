class AdminsController < ApplicationController
  protect_from_forgery
  layout 'admin'


  def index


   @products = Product.find(:all)


  end


  def get_orders
   @orders = Order.find(:all, :order=>"created_at")

@return_hash = []

for order in @orders
                @return_hash << {:order_id=>order.id, :created_at=> order.created_at }
end


respond_to do |format|
     format.js { render :json=>@return_hash.to_json }
end


  end


end
