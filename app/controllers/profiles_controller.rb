class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_without_id!, :only => :show
  load_and_authorize_resource # sets @profile
  before_filter :create_theme_if_missing!

  respond_to :html, :js

  def show
  end

  def new
  end

  def create
    @profile = current_user.build_profile
    if @profile.update_attributes(params[:profile])
      flash[:success] = t('profile.edit_form.save_success')
    end
    respond_with(@profile)
  end

  def edit
    @backgrounds = Theme.backgrounds
  end

  def update
    if @profile.update_attributes(params[:profile])
      flash[:success] = t('profile.edit_form.save_success')
    end
    respond_with(@profile)
  end

  private

  def redirect_without_id!
    if params[:id].to_s.blank?
      if current_user.profile
        redirect_to current_user.profile
      else
        flash[:warning] = t('registration.create_profile_message')
        redirect_to new_profile_path
      end
      false
    end
  end

  def create_theme_if_missing!
    @profile.create_theme_if_missing!
  end

end
