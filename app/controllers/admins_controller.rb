class AdminsController < ApplicationController
  protect_from_forgery
  layout 'admin'


def get_summary 


@return_hash = []

@products = Product.find(:all)

for prod in @products 

@total = 0
@orders = Order.find_all_by_product_id(prod.id)

		for order in @orders
		@total = @total + order.price
		end
		@return_hash << { :name=>prod.name, :count=>@total}

end


respond_to do |format|
     format.js { render :json=>@return_hash.to_json }
end


end

  def index


   @products = Product.find(:all)


  end


  def get_orders
   @orders = Order.find(:all, :order=>"created_at")

@return_hash = []

for order in @orders

@user = User.find(order.user_id)
@prod_string = ""

@items = Item.find_all_by_order_id(order.id)

@global_quantity = 0

for item in @items
@prod = Product.find(item.product_id)
@global_quantity = item.quantity.to_i + @global_quantity
@prod_string = @prod_string + "/"+ @prod.name
end


@address_string = order.address_two + "," + order.city + "," + order.state + "," + order.zip + "," + order.country 
        @date = order.created_at.strftime("%m/%d/%y")

                @return_hash << {:order_id=>order.uuid, :status=>order.status, :name=>order.name, :phone=>order.phone, :num_items=>@global_quantity, :total=>order.total, :email=>@user.email, :order_id=>order.id, :created_at=> @date, :products=>@prod_string, :address=>@address_string }

end


respond_to do |format|
     format.js { render :json=>@return_hash.to_json }
end


  end


end
