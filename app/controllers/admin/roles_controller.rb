class Admin::RolesController < ApplicationController
  require_role :admin
  layout 'admin'

  def index
    @users = User.paginate :page => params[:page],:per_page => 10
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_roles }
    end
  end

end
