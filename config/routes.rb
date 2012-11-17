Selfstarter::Application.routes.draw do
  root :to => 'preorder#index'
  match '/preorder'               => 'preorder#index'
  match '/products'               => 'products#index'
  match '/checkout'               => 'products#index'
  match '/feedback'               => 'contacts#index'
  match '/signin'               => 'users#index'
  match '/feedback'               => 'contacts#index'
  match '/admin'               => 'admins#index'

  get 'preorder/checkout'
  match '/preorder/share/:uuid'   => 'preorder#share', :via => :get
  match '/preorder/ipn'           => 'preorder#ipn', :via => :post
  match '/preorder/prefill'       => 'preorder#prefill'
  match '/preorder/postfill'      => 'preorder#postfill'
end
