class AccountSubGroupsController < ApplicationController
  layout 'accounting'
  # GET /account_sub_groups
  # GET /account_sub_groups.xml
  def index
    @account_sub_groups = user_default_branch.account_sub_groups.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @account_sub_groups }
    end
  end

  # GET /account_sub_groups/1
  # GET /account_sub_groups/1.xml
  def show
    @account_sub_group = user_default_branch.account_sub_groups.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account_sub_group }
    end
  end

  # GET /account_sub_groups/new
  # GET /account_sub_groups/new.xml
  def new
    @account_sub_group = user_default_branch.account_sub_groups.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account_sub_group }
    end
  end

  # GET /account_sub_groups/1/edit
  def edit
    @account_sub_group = user_default_branch.account_sub_groups.find(params[:id])
  end

  # POST /account_sub_groups
  # POST /account_sub_groups.xml
  def create
    @account_sub_group = user_default_branch.account_sub_groups.build(params[:account_sub_group])
    @account_sub_group.parent_id = params[:account_sub_group][:parent_id] if user_default_branch.account_main_groups.exists?(params[:account_sub_group][:parent_id])
    
    respond_to do |format|
      if @account_sub_group.save
        flash[:notice] = 'AccountSubGroup was successfully created.'
        format.html { redirect_to(@account_sub_group) }
        format.xml  { render :xml => @account_sub_group, :status => :created, :location => @account_sub_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account_sub_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /account_sub_groups/1
  # PUT /account_sub_groups/1.xml
  def update
    @account_sub_group = user_default_branch.account_sub_groups.find(params[:id])
    @account_sub_group.parent_id = params[:account_sub_group][:parent_id] if user_default_branch.account_main_groups.exists?(params[:account_sub_group][:parent_id])
    
    respond_to do |format|
      if @account_sub_group.update_attributes(params[:account_sub_group])
        flash[:notice] = 'AccountSubGroup was successfully updated.'
        format.html { redirect_to(@account_sub_group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account_sub_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /account_sub_groups/1
  # DELETE /account_sub_groups/1.xml
  def destroy
    @account_sub_group = user_default_branch.account_sub_groups.find(params[:id])
    @account_sub_group.destroy

    respond_to do |format|
      format.html { redirect_to(account_sub_groups_url) }
      format.xml  { head :ok }
    end
  end
end
