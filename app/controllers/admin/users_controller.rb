class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :js

  def update
    if params[:do] == 'activate'
      @user.activate!
    elsif params[:do] == 'reject'
      @user.reject!
    end
    respond_with @user do |format|
      format.html { redirect_to admin_dashboard_path }
    end
  end
end
