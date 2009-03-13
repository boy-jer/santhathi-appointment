class DeactivateSlotsController < ApplicationController

  layout 'cms'
  def index
    @deactivate_slots = DeactivateSlot.paginate :page => params[:page],:per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deactivate_slots }
    end
  end

  # GET /deactivate_slots/1
  # GET /deactivate_slots/1.xml
  def show
    @deactivate_slot = DeactivateSlot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deactivate_slot }
       format.js { render :layout => false }
    end
  end

  # GET /deactivate_slots/new
  # GET /deactivate_slots/new.xml
  def new
    @deactivate_slot = DeactivateSlot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deactivate_slot }
    end
  end

  # GET /deactivate_slots/1/edit
  def edit
    @deactivate_slot = DeactivateSlot.find(params[:id])
  end

  # POST /deactivate_slots
  # POST /deactivate_slots.xml
  def create
    @deactivate_slot = DeactivateSlot.new(params[:deactivate_slot])

    respond_to do |format|
      if @deactivate_slot.save
        flash[:notice] = 'DeactivateSlot was successfully created.'
        format.html { redirect_to(@deactivate_slot) }
        format.xml  { render :xml => @deactivate_slot, :status => :created, :location => @deactivate_slot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deactivate_slot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deactivate_slots/1
  # PUT /deactivate_slots/1.xml
  def update
    @deactivate_slot = DeactivateSlot.find(params[:id])

    respond_to do |format|
      if @deactivate_slot.update_attributes(params[:deactivate_slot])
        flash[:notice] = 'DeactivateSlot was successfully updated.'
        format.html { redirect_to(@deactivate_slot) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deactivate_slot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /deactivate_slots/1
  # DELETE /deactivate_slots/1.xml
  def destroy
    @deactivate_slot = DeactivateSlot.find(params[:id])
    @deactivate_slot.destroy

    respond_to do |format|
      format.html { redirect_to(deactivate_slots_url) }
      format.xml  { head :ok }
    end
  end
end
