class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user


  def current_user_session
#    puts session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    @current_user = current_user_session && current_user_session.record
  end


end
