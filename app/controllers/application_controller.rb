class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_timezone
  after_filter :flash_to_headers

  layout :layout

  def layout
    'application' unless params[:_pjax]
  end

  def set_timezone
    if current_user && current_user.timezone
      Time.zone = current_user.timezone 
    end
  end

  include Setting
  helper_method :s

  def flash_to_headers
    if request.xhr?
      [:info, :success, :warning, :error].each do |type|
        response.headers["X-Message-#{type}"] = flash[type] if flash[type]
      end
      flash.discard
    end
  end

  def email?() SMTP_OK end
  helper_method :email?

  def authorize_admin!
    unless current_user && current_user.roles?(:admin)
      render :text => 'not authorized', :status => :unauthorized
      return false
    end
  end
end
