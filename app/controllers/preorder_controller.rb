class PreorderController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :ipn
  layout 'application'

  def index


   @products = Product.find(:all)


  end

  def checkout
  end

  def prefill
    @user  = User.find_or_create_by_email!(params[:email])

    if @user
    @user  = User.create(:email=>params[:email])
    end

   #if param[:id]
   #@product = Product.find(params[:id])
   #end

   if @user   
    @order = Order.prefill!(:user_id => @user.id, :name=>params[:email], :price=>100)
   end    


puts "size"
@count = 0
while (@count < params[:products].size)

@id = params[:products][@count]
@quantity = params[:product][@id]
@item = Item.create(:quantity=> @quantity, :product_id=>@id)
@item.order_id = @order.id
@item.save

@count = @count + 1

end

 
    # This is where all the magic happens. We create a multi-use token with Amazon, letting us charge the user's Amazon account
    # Then, if they confirm the payment, Amazon POSTs us their shipping details and phone number
    # From there, we save it, and voila, we got ourselves a preorder!


    @pipeline = AmazonFlexPay.multi_use_pipeline(@order.uuid, :transaction_amount => params[:deposit], :global_amount_limit => Settings.charge_limit, :collect_shipping_address => "True", :payment_reason => Settings.payment_description)
    redirect_to @pipeline.url("#{request.scheme}://#{request.host}/preorder/postfill")
  end

  def postfill
    unless params[:callerReference].blank?
      @order = Order.postfill!(params)
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
