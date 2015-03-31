class UserSessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		flash[:success] = "You have successfully logged in!"
      redirect_to titles_path
  	else 
  		flash[:error] = "There was a problem logging in. Please check your email and password."
  		render action: 'new'
  	end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to login_path, notice: "You have been logged out."
  end
end
