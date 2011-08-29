class Admin::Masters::ServicesController < ApplicationController
  layout 'admin'

  def index
    @search = Service.new_search(params[:search])
    @search.per_page ||= 50
    @tests = @search.all
    
    @child_list = Service.lab_services.top_level
    respond_to do |format|
              format.html
              format.js {
                      render :update do |page|
                        page.replace_html 'lab-test', :partial => 'lab_test_result'
                      end
                      }
    end
  end

  def new
    @lab_test = Service.new
    @child_list = Service.lab_services.top_level
    @lab_test.account = user_default_branch.accounts.find_by_name(CASH_AC[:name])
  end

  def edit
     @lab_test = Service.find(params[:id])
  end

  def show
    @lab_test = Service.find(params[:id])
  end

  def create
    lab_test = params[:lab_test]
    @lab_test = Service.new(lab_test)
    parent = Service.find(lab_test[:parent_id]) unless lab_test[:parent_id].blank?
    @lab_test.depth = parent.blank? ? 1 : parent.depth.to_i + 1

    if @lab_test.save
      flash[:notice] = 'Laboratory test is successfully created.'
      redirect_to(admin_masters_lab_tests_url)
    else
      render :action => "new"
    end
  end

   def update
    @lab_test = Service.find(params[:id])
    if @lab_test.update_attributes(params[:lab_test])
      flash[:notice] = 'Lab test is successfully updated.'
      redirect_to(admin_masters_lab_tests_url)
    else
      render :action => "edit"
    end
  end

  def destroy
     Service.find(params[:id]).destroy
     redirect_to(admin_masters_lab_tests_url)
  end
end

