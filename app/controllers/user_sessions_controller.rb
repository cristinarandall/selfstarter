class UserSessionsController < ApplicationController
  protect_from_forgery
  layout 'login'

  def create_old
    puts 'create user session'
   if params[:password]
    @user_session = UserSession.new(:email=>params[:username], :password=>params[:password])
@email = params[:username]
   else
    @user_session = UserSession.new(:email=>params[:useremail], :password=>params[:userpassword])
@email = params[:useremail]
   end
    if @user_session.save
      flash[:login] = "Bienvenido"
     @user  = User.find(:first, :conditions=> ['email ~* ?', @email])

     if @user
     
     else
             if params[:conversion]
              redirect_to :controller => 'conversions', :action => 'index', :success=>"false"
             else
              redirect_to :controller => 'actions', :action => 'new', :success=>"false"
             end
     end

    else

        #to do: alert the user if their account is not active
        flash[:login] = "usaurio y contrasena no son correctos"
                redirect_to :controller => 'actions', :action => 'new', :success=>"false"
    end

  end


def index


end


  def sign_out
    puts 'destroy usersession'
    @user_session = UserSession.find

if (current_user) && (@user_session)


if current_user.company_id
        @business = true
                if @user_session
                        @user_session.destroy
                end
                redirect_to :controller => 'landing', :action => 'index', :logout=>true
else
        if @user_session
                @user_session.destroy
        end
                redirect_to :controller => 'landing', :action => 'index', :logout=>true
end

end
  end


end
