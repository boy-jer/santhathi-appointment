class DashboardController < ApplicationController
  # GET /
  # The default dashboard

  def home
    render :layout => 'home'
  end

  def index
     render :layout => 'site'
  end
end
