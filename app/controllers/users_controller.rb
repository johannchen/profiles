class UsersController < Devise::RegistrationsController
  def update
    if params[resource_name]['current_password'] ? resource.update_with_password(params[resource_name]) : resource.update_attributes(params[resource_name])
      flash[:notice] = t('account.edit_form.save_success')
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource){ render_with_scope :edit }
    end
  end

  private

  def after_update_path_for(resource)
    resource ? resource.profile : '/'
  end
end
