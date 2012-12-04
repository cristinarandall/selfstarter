Selfstarter::Application.routes.draw do
  root :to => 'preorder#index'
  match '/preorder'               => 'preorder#index'
  match '/products'               => 'products#index'
  match '/checkout'               => 'products#index'
  match '/feedback'               => 'contacts#index'
  match '/get_orders'               => 'admins#get_orders'
  match '/single_order'		    => 'admins#single_order'
  match '/signin'               => 'users#index'
  match '/admin'               => 'admins#index'
  match '/send_message'               => 'products#send_message'
  match '/products_in_order'                => 'admin#products_in_order'
  get 'preorder/checkout'
  match '/preorder/share/:uuid'   => 'preorder#share', :via => :get
  match '/preorder/ipn'           => 'preorder#ipn', :via => :post
  match '/preorder/prefill'       => 'preorder#prefill'
  match '/preorder/postfill'      => 'preorder#postfill'
end
