class AccountGroupTypesController < ApplicationController
  layout 'accounting'

  # GET /account_group_types
  # GET /account_group_types.xml
  def index
    @account_group_types = user_default_branch.account_group_types.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @account_group_types }
    end
  end

  # GET /account_group_types/1
  # GET /account_group_types/1.xml
  def show
    @account_group_type = user_default_branch.account_group_types.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account_group_type }
    end
  end

  # GET /account_group_types/new
  # GET /account_group_types/new.xml
  def new
    @account_group_type = user_default_branch.account_group_types.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account_group_type }
    end
  end

  # GET /account_group_types/1/edit
  def edit
    @account_group_type = user_default_branch.account_group_types.find(params[:id])
  end

  # POST /account_group_types
  # POST /account_group_types.xml
  def create
    @account_group_type = user_default_branch.account_group_types.build(params[:account_group_type])

    respond_to do |format|
      if @account_group_type.save
        flash[:notice] = 'AccountGroupType was successfully created.'
        format.html { redirect_to(@account_group_type) }
        format.xml  { render :xml => @account_group_type, :status => :created, :location => @account_group_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account_group_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /account_group_types/1
  # PUT /account_group_types/1.xml
  def update
    @account_group_type = user_default_branch.account_group_types.find(params[:id])

    respond_to do |format|
      if @account_group_type.update_attributes(params[:account_group_type])
        flash[:notice] = 'AccountGroupType was successfully updated.'
        format.html { redirect_to(@account_group_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account_group_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /account_group_types/1
  # DELETE /account_group_types/1.xml
  def destroy
    @account_group_type = user_default_branch.account_group_types.find(params[:id])
    @account_group_type.destroy

    respond_to do |format|
      format.html { redirect_to(account_group_types_url) }
      format.xml  { head :ok }
    end
  end
end
