class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:session][:password] != "" && params[:session][:email] != ""
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        flash.clear
        log_in(user)
        redirect_to root_path
      else
        flash[:danger] = "Incorrect Username and/or Password"
        render 'new'
      end
    end
  end
  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to login_path
  end
end
