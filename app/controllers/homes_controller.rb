class HomesController < ApplicationController

  def show
    redirect_to my_profile_path if current_user
  end

end
