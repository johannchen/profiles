class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_timezone

  def set_timezone
    if current_user && current_user.timezone
      Time.zone = current_user.timezone 
    end
  end

  include Setting
  helper_method :s
end
