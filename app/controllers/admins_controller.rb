class AdminsController < ApplicationController
  protect_from_forgery
  layout 'admin'


def export 

    @orders = Order.order(:created_at) #find(:all, :order=>"created_at ASC")
    respond_to do |format|
      format.csv { send_data @orders.to_csv_alternative }
    end

end


def pay_balance


@order = Order.find(params[:order_id])


options = {}
options[:ChargeFeeTo] = "Caller"
  response = AmazonFlexPay.pay(@order.balance, 'USD', @order.token, @order.uuid)
@order.balance_payment_transaction_id =response.transaction_id
@order.status = "Paid Deposit & Balance" 
@order.save




@return_hash = []



respond_to do |format|
     format.js { render :json=>@return_hash.to_json }
end

end

def products_in_order

@return_hash = []


@items = Item.find_all_by_order_id(params[:id])

for item in @items
	@prod = Product.find(item.product_id)
                @return_hash << { :name=>@prod.name, :quantity=>item.quantity}
end

respond_to do |format|
     format.js { render :json=>@return_hash.to_json }
end

end

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

if current_user && current_user.email.match("payments@gritworks.com")  
   @products = Product.find(:all)

else 
              redirect_to :controller => 'user_sessions', :action => 'index', :success=>"false"
end


  end


  def single_order


@order = Order.find(params[:id])
@return_hash = []

if @order.user_id
@user = User.find(@order.user_id)
end

if @user
@name = @user.name
@email = @user.email
else 
@name = ''
@email = ''
end

if @order.address_two && @order.city && @order.state && @order.zip && @order.country
@address_string = @order.address_two + "," + @order.city + "," + @order.state + "," + @order.zip + "," + @order.country
elsif @order.address_one && @order.city && @order.state && @order.zip && @order.country
@address_string = @order.address_one + "," + @order.city + "," + @order.state + "," + @order.zip + "," + @order.country
elsif @order.city && @order.state
@address_string = @order.city + "," + @order.state
end




if (@order.balance_payment_transaction_id)                
@return_hash << { :gritworks=>@order.gritworks, :order_id=>@order.id, :balance_payment_transaction_id=> @order.balance_payment_transaction_id, :status=>@order.status, :balance=> @order.balance, :address=>@address_string, :deposit=>@order.deposit, :total=>@order.total, :email=>@email, :name=>@name}
else
@return_hash << { :gritworks=>@order.gritworks, :order_id=>@order.id, :status=>@order.status, :balance=> @order.balance, :address=>@address_string, :deposit=>@order.deposit, :total=>@order.total, :email=>@email, :name=>@name}
end


respond_to do |format|
     format.js { render :json=>@return_hash.to_json }
end

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

if @prod_string.match(@prod.name)

else 
@prod_string = @prod_string + "/"+ @prod.name
end

end

if @user 
@name = @user.name
else
@name = ""
end


if order.address_two && order.city && order.state && order.zip && order.country
@address_string = order.address_two + "," + order.city + "," + order.state + "," + order.zip + "," + order.country 
elsif order.city && order.state
@address_string = order.city + "," + order.state
end

        @date = order.created_at.strftime("%m/%d/%y")


                @return_hash << {:gritworks=>order.gritworks, :order_id=>order.uuid, :status=>order.status, :name=>@name, :phone=>order.phone, :num_items=>@global_quantity, :total=>order.total, :email=>@user.email, :id=>order.id, :created_at=> @date, :products=>@prod_string, :address=>@address_string }

end


respond_to do |format|
     format.js { render :json=>@return_hash.to_json }
end


  end


end
