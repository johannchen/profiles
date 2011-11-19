module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    root_path
  end

  def sign_up_page
    new_user_registration_path
  end
end

RSpec.configuration.include NavigationHelpers #, :type => :acceptance
