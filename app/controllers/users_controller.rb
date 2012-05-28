class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  no_login_required
  
  def sign_up
    redirect_to '/' if !self.current_user.nil?
    session[:omniauth] = nil
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.apply_omniauth(session[:omniauth]) unless session[:omniauth].nil?
    if @user.save
      flash[:notice]= "Signed in successfully."
      self.current_user = @user
      redirect_to "/"
    else
      render :template => "users/sign_up"
    end
  end
  
  def logout
    cookies[:session_token] = { :expires => 1.day.ago }
    self.current_user.forget_me if self.current_user
    self.current_user = nil
    flash[:notice] = "Signed out successfully."
    redirect_to '/'
  end
end
