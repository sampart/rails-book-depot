class SessionsController < ApplicationController
  SETUP_USER_ID = "setup"

  skip_before_action :authorize
  
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    elsif User.count.zero?
      session[:user_id] = SETUP_USER_ID
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid user/password combination."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: "Logged out"
  end
end
