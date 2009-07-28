class UserRolesController < ApplicationController
  require_role :admin
  layout 'admin'


  def edit
    @user = User.find(params[:id])
    @roles = @user.roles.map{ |role| role.name }
  end


  def update
      user = User.find(params[:id])
      user.roles.clear

      params[:roles].each_key{ |key| role = Role.find_by_name(key)
                                     user.roles << role unless role.blank?
                             }  unless  params[:roles].blank?


      respond_to do |format|
        flash[:notice] = 'UserRole was successfully updated.'
        format.html { redirect_to( admin_roles_path() ) }
        format.xml  { head :ok }
     end
  end

 end
