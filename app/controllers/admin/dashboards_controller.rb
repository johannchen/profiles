class Admin::DashboardsController < ApplicationController

  def show
    @actions = AdminActionsPresenter.new
  end

end
