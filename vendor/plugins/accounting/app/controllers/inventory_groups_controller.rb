class InventoryGroupsController < ApplicationController
  layout 'inventory'
  # GET /inventory_groups
  # GET /inventory_groups.xml
  def index
    @inventory_groups = user_default_branch.inventory_groups.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inventory_groups }
    end
  end

  # GET /inventory_groups/1
  # GET /inventory_groups/1.xml
  def show
    @inventory_group = user_default_branch.inventory_groups.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inventory_group }
    end
  end

  # GET /inventory_groups/new
  # GET /inventory_groups/new.xml
  def new
    @inventory_group = user_default_branch.inventory_groups.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inventory_group }
    end
  end

  # GET /inventory_groups/1/edit
  def edit
    @inventory_group = user_default_branch.inventory_groups.find(params[:id])
  end

  # POST /inventory_groups
  # POST /inventory_groups.xml
  def create
    @inventory_group = user_default_branch.inventory_groups.new(params[:inventory_group])

    respond_to do |format|
      if @inventory_group.save
        flash[:notice] = 'InventoryGroup was successfully created.'
        format.html { redirect_to(@inventory_group) }
        format.xml  { render :xml => @inventory_group, :status => :created, :location => @inventory_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inventory_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_groups/1
  # PUT /inventory_groups/1.xml
  def update
    @inventory_group = user_default_branch.inventory_groups.find(params[:id])

    respond_to do |format|
      if @inventory_group.update_attributes(params[:inventory_group])
        flash[:notice] = 'InventoryGroup was successfully updated.'
        format.html { redirect_to(@inventory_group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inventory_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_groups/1
  # DELETE /inventory_groups/1.xml
  def destroy
    @inventory_group = user_default_branch.inventory_groups.find(params[:id])
    @inventory_group.destroy

    respond_to do |format|
      format.html { redirect_to(inventory_groups_url) }
      format.xml  { head :ok }
    end
  end
end
