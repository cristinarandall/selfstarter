class User < ActiveRecord::Base
  attr_accessible :email, :name, :persistence_token, :password_salt, :password_salt, :perishable_token
  has_many :orders


  acts_as_authentic do |config|
    #disable_perishable_token_maintenance(true)
    config.login_field = 'email'
    config.validate_password_field = false
  end


end
