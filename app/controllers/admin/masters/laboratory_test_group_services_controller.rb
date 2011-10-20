class Admin::Masters::LaboratoryTestGroupServicesController < ApplicationController
  layout 'admin'

  def index
     @group = LaboratoryTestGroup.find(params[:laboratory_test_group_id])
     @service_ids = @group.services.collect(&:id)
     @services = Service.find(:all, :conditions => ["department_id = ?",Department.find(:first, :select => :id, :conditions => "dept_name like '%Lab%'").id ])
  end

  def create
     @group = LaboratoryTestGroup.find(params[:laboratory_test_group_id])
     Service.update_all("laboratory_test_group_id = null",  "laboratory_test_group_id = #{@group.id}")

     if params[:service] && !params[:service][:service_ids].blank?
       value = params[:service][:service_ids]
       Service.update_all("laboratory_test_group_id = #{@group.id} ",  "id in (#{value.join(',')})")
     end
     redirect_to admin_masters_laboratory_test_group_laboratory_test_group_services_path(@group.id)
  end

end

