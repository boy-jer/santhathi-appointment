class AccountMainGroupsController < ApplicationController
  layout 'accounting'
  # GET /account_main_groups
  # GET /account_main_groups.xml
  def index
    @account_main_groups = user_default_branch.account_main_groups.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @account_main_groups }
    end
  end

  # GET /account_main_groups/1
  # GET /account_main_groups/1.xml
  def show
    @account_main_group = user_default_branch.account_main_groups.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account_main_group }
    end
  end

  # GET /account_main_groups/new
  # GET /account_main_groups/new.xml
  def new
    @account_main_group = user_default_branch.account_main_groups.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account_main_group }
    end
  end

  # GET /account_main_groups/1/edit
  def edit
    @account_main_group = user_default_branch.account_main_groups.find(params[:id])
  end

  # POST /account_main_groups
  # POST /account_main_groups.xml
  def create
    @account_main_group = user_default_branch.account_main_groups.build(params[:account_main_group])
    @account_main_group.account_group_type_id = params[:account_main_group][:account_group_type_id] if user_default_branch.account_group_types.exists?(params[:account_main_group][:account_group_type_id])
    
    respond_to do |format|
      if @account_main_group.save
        flash[:notice] = 'AccountMainGroup was successfully created.'
        format.html { redirect_to(@account_main_group) }
        format.xml  { render :xml => @account_main_group, :status => :created, :location => @account_main_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account_main_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /account_main_groups/1
  # PUT /account_main_groups/1.xml
  def update
    @account_main_group = user_default_branch.account_main_groups.find(params[:id])
    @account_main_group.account_group_type_id = params[:account_main_group][:account_group_type_id] if user_default_branch.account_group_types.exists?(params[:account_main_group][:account_group_type_id])
    
    respond_to do |format|
      if @account_main_group.update_attributes(params[:account_main_group])
        flash[:notice] = 'AccountMainGroup was successfully updated.'
        format.html { redirect_to(@account_main_group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account_main_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /account_main_groups/1
  # DELETE /account_main_groups/1.xml
  def destroy
    @account_main_group = user_default_branch.account_main_groups.find(params[:id])
    @account_main_group.destroy

    respond_to do |format|
      format.html { redirect_to(account_main_groups_url) }
      format.xml  { head :ok }
    end
  end
end
