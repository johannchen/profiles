module DeviseHelper
  def devise_error_messages!
    errors_for(resource)
  end
end
