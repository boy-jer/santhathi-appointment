class InventoryItemsController < ApplicationController
  layout 'inventory'
  # GET /inventory_items
  # GET /inventory_items.xml
  def index
    @inventory_items = user_default_branch.inventory_items.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inventory_items }
    end
  end

  # GET /inventory_items/1
  # GET /inventory_items/1.xml
  def show
    @inventory_item = user_default_branch.inventory_items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inventory_item }
    end
  end

  # GET /inventory_items/new
  # GET /inventory_items/new.xml
  def new
    @inventory_item = user_default_branch.inventory_items.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inventory_item }
    end
  end

  # GET /inventory_items/1/edit
  def edit
    @inventory_item = user_default_branch.inventory_items.find(params[:id])
  end

  # POST /inventory_items
  # POST /inventory_items.xml
  def create
    @inventory_item = user_default_branch.inventory_items.build(params[:inventory_item])
    @inventory_item.inventory_unit_of_measurement_id = params[:inventory_item][:inventory_unit_of_measurement_id] if user_default_branch.inventory_unit_of_measurements.exists?(params[:inventory_item][:inventory_unit_of_measurement_id])
    @inventory_item.inventory_group_id = params[:inventory_item][:inventory_group_id] if user_default_branch.inventory_groups.exists?(params[:inventory_item][:inventory_group_id])

    respond_to do |format|
      if @inventory_item.save
        flash[:notice] = 'InventoryItem was successfully created.'
        format.html { redirect_to(@inventory_item) }
        format.xml  { render :xml => @inventory_item, :status => :created, :location => @inventory_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inventory_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_items/1
  # PUT /inventory_items/1.xml
  def update
    @inventory_item = user_default_branch.inventory_items.find(params[:id])
    @inventory_item.inventory_unit_of_measurement_id = params[:inventory_item][:inventory_unit_of_measurement_id] if user_default_branch.inventory_unit_of_measurements.exists?(params[:inventory_item][:inventory_unit_of_measurement_id])
    @inventory_item.inventory_group_id = params[:inventory_item][:inventory_group_id] if user_default_branch.inventory_groups.exists?(params[:inventory_item][:inventory_group_id])

    respond_to do |format|
      if @inventory_item.update_attributes(params[:inventory_item])
        flash[:notice] = 'InventoryItem was successfully updated.'
        format.html { redirect_to(@inventory_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inventory_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_items/1
  # DELETE /inventory_items/1.xml
  def destroy
    @inventory_item = user_default_branch.inventory_items.find(params[:id])
    @inventory_item.destroy

    respond_to do |format|
      format.html { redirect_to(inventory_items_url) }
      format.xml  { head :ok }
    end
  end

  def transactions_list
    @inventory_item_transactions = user_default_branch.inventory_items.find(params[:id]).inventory_transaction_items.all(:order => 'transaction_date')
    
  end
end
