class DashboardController < ApplicationController
  # GET /
  # The default dashboard
  skip_before_filter :logged_in

  def home
    render :layout => 'home'
  end

  def index
     render :layout => 'site'
  end
end
