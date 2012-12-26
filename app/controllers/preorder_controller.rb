class PreorderController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :ipn
  layout 'application'

  def index


   @products = Product.find(:all)


  end

  def checkout
  end

  def prefill
    @user  = User.find_by_email(params[:email])

    if @user.nil?
    @user  = User.create(:email=>params[:email], :name=>params[:name])
    end


puts "user id"
puts @user.id.to_s

   if @user   
    @order = Order.prefill!(:user_id => @user.id, :name=>params[:email], :price=>100)
   end    

@count = 0
while (@count < params[:products].size)

@id = params[:products][@count]
@quantity = params[:product][@id]
if (@quantity) && (@quantity.to_i > 0)
@item = Item.create(:quantity=> @quantity, :product_id=>@id)

@item.order_id = @order.id
@item.save
end
@count = @count + 1

end


@order.balance = params[:balance]
@order.deposit = params[:deposit]
@order_total = params[:balance].to_f + params[:deposit].to_f

@order.total =  @order_total.to_i #@order_total.round(2)

@order.save

    # This is where all the magic happens. We create a multi-use token with Amazon, letting us charge the user's Amazon account
    # Then, if they confirm the payment, Amazon POSTs us their shipping details and phone number
    # From there, we save it, and voila, we got ourselves a preorder!

puts "total"
puts @order.total.to_s

puts "deposit"
puts @order.deposit.to_s

puts "balance"
puts @order.balance.to_s


@description = "Deposit made at time of pre-order is non-refundable.  Balance is due and will be charged to your card just prior to the shipment of the pre-order to you."
    @pipeline = AmazonFlexPay.multi_use_pipeline(@order.uuid, :transaction_amount => params[:deposit], :global_amount_limit => @order.total.to_i, :collect_shipping_address => "True", :payment_reason => @description, :amount_type=>"Minimum")


@items = Item.find_all_by_order_id(@order.id)

#Notifier.order_status(@order, @items, params[:email])
#Notifier.order_status(@order, @items,"payments@gritworks.com")
    redirect_to @pipeline.url("#{request.scheme}://#{request.host}/preorder/postfill")
  end

  def postfill
    unless params[:callerReference].blank?
      @order = Order.postfill!(params)
      @order.gritworks_number
@items = Item.find_all_by_order_id(@order.id)
        Notifier.order_status(@order, @items, @order.name)
        Notifier.order_status(@order, @items,"payments@gritworks.com")


    end


    # "A" means the user cancelled the preorder before clicking "Confirm" on Amazon Payments.
    if params['status'] != 'A' && @order.present?
      redirect_to :action => :share, :uuid => @order.uuid
    else
      redirect_to root_url
    end
  end

  def share
    @order = Order.find_by_uuid(params[:uuid])
  end

  def ipn
  end
end
