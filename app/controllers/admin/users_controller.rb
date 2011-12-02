class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :js

  def update
    if params[:do]
      update_activation
    elsif params[:user]
      if @user.update_attributes(params[:user], :as => :admin)
        flash[:success] = t('admin.user.save_success')
      end
      respond_with(@user)
    end
  end

  def update_activation
    if params[:do] == 'activate'
      @user.activate!
      # send email notification to user
      UserMailer.activation_email(current_user, @user).deliver
    elsif params[:do] == 'reject'
      @user.reject!
      UserMailer.rejection_email(current_user, @user).deliver
    elsif params[:do] == 'inactivate'
      @user.inactivate!
    end
    respond_with @user do |format|
      format.html { redirect_to admin_dashboard_path }
    end
  end
end
