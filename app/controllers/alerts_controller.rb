class AlertsController < ApplicationController
  load_and_authorize_resource :profile

  def destroy
    @profile.alerts.delete(params[:id].to_sym)
    @profile.save(:validate => false)
    render :text => 'deleted', :status => :ok
  end

end
