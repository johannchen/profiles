class SessionsController < ApplicationController

  # omniauth callbacks
  
  def facebook
    @user = User.find_and_update(env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = I18n.t('session.success')
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
