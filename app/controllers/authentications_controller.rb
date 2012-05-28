class AuthenticationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  no_login_required
  
  def index
    @authentications = current_user.authentications if current_user
    render :layout => false
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      self.current_user = authentication.user
      redirect_to '/'
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      @user = User.new
      if omniauth[:provider] == 'twitter'
        @user.login = omniauth[:info].nickname
      elsif omniauth[:provider] == 'facebook'
        @user.login = omniauth[:info].email
        @user.name = omniauth[:info].name
        @user.email = omniauth[:info].email
      end

      @user.apply_omniauth(omniauth)
      if @user.save
        flash[:notice]= "Signed in successfully."
        self.current_user = @user
        redirect_to "/"
      else
        session[:omniauth] = omniauth.except('extra')
        render :template => "users/sign_up"
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
