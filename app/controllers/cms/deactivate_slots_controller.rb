class Cms::DeactivateSlotsController < ApplicationController
  layout 'cms'

  def index
    @deactivate_slots = DeactivateSlot.paginate :page => params[:page],:per_page => 10
  end

  def show
    @deactivate_slot = DeactivateSlot.find(params[:id])
    render :layout => false
  end

  def new
    @deactivate_slot = DeactivateSlot.new
  end

  def edit
    @deactivate_slot = DeactivateSlot.find(params[:id])
  end

  def create
    @deactivate_slot = DeactivateSlot.new(params[:deactivate_slot])
    @deactivate_slot.doctor_id = params[:appointment][:doctor_id]
    if @deactivate_slot.save
      flash[:notice] = 'DeactivateSlot was successfully created.'
      redirect_to(cms_deactivate_slots_url())
    else
      render :action => "new"
    end
  end

  def update
    @deactivate_slot = DeactivateSlot.find(params[:id])
    if @deactivate_slot.update_attributes(params[:deactivate_slot])
      flash[:notice] = 'DeactivateSlot was successfully updated.'
      redirect_to(cms_deactivate_slot_url(@deactivate_slot) )
    else
      render :action => "edit"
    end
  end

  def destroy
    @deactivate_slot = DeactivateSlot.find(params[:id])
    @deactivate_slot.destroy
    redirect_to(cms_deactivate_slots_url())
  end

end
