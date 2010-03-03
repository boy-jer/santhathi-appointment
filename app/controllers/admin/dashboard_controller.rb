class Admin::DashboardController < ApplicationController
  require_role :admin
  layout 'admin'

  def index
  end

  def masters
  end

  def reports
  end

end

