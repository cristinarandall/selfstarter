class AdminsController < ApplicationController
  protect_from_forgery
  layout 'admin'


  def index


   @products = Product.find(:all)


  end


end
