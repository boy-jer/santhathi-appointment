class Laboratory::InventoryItemsUsedForTestsController < ApplicationController
  layout 'laboratory'
  before_filter :find_lab_test

  def index
    @items_used = @lab_test.inventory_items_used_for_tests
  end

   def new
    @inventory_item_used_for_test = @lab_test.inventory_items_used_for_tests.new
  end
  
  def edit
    @inventory_item_used_for_test = @lab_test.inventory_items_used_for_tests.find(params[:id])
  end

  def create
    @inventory_item_used_for_test = @lab_test.inventory_items_used_for_tests.new(params[:inventory_item_used_for_test])
    if @inventory_item_used_for_test.save
      flash[:notice] = 'Inventory item is successfully added as item used for the test.'
      redirect_to(laboratory_lab_test_inventory_items_used_for_tests_path(@lab_test))
    else
      render :action => "new"
    end
  end

  def update
    @inventory_item_used_for_test = @lab_test.inventory_items_used_for_tests.find(params[:id])
    if @inventory_item_used_for_test.update_attributes(params[:inventory_items_used_for_test])
      flash[:notice] = 'Inventory item used for the test is successfully updated.'
      redirect_to(laboratory_lab_test_inventory_items_used_for_tests_path(@lab_test))
    else
      render :action => "edit"
    end
  end

  def destroy
    @inventory_item_used_for_test = @lab_test.inventory_items_used_for_tests.find(params[:id])
    @inventory_item_used_for_test.destroy
    redirect_to(laboratory_lab_test_inventory_items_used_for_tests_path(@lab_test))
  end

  private

  def find_lab_test
    @lab_test = Service.find(params[:lab_test_id])
  end
end
