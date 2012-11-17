class ProductsController < ApplicationController
  protect_from_forgery
  layout 'application_alternative'



  def index


@products = Product.find(:all)

  end


  def send_message


      Notifier.company_message(params[:message], params[:name], "", params[:email], 1)

      redirect_to "/products"


  end

end
