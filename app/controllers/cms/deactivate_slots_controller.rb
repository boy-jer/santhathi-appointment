class Cms::DeactivateSlotsController < ApplicationController
  layout 'cms'

  def index
  	@search = DeactivateSlot.new_search(params[:search])
  	@search.per_page ||= 15
  	@deactivate_slots = @search.all
    # @deactivate_slots = DeactivateSlot.paginate :page => params[:page],:per_page => 10
    respond_to do |format|
        format.html
        format.js {
                     render :update do |page|
                        page.replace_html 'deactivate_slot', :partial => '/cms/deactivate_slots/deactivate_slots_list'
                     end
                  }
              end
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

    start_date =  Date.parse("#{params[:deactivate_slot]['from_date(1i)']}/#{params[:deactivate_slot]['from_date(2i)']}/#{params[:deactivate_slot]['from_date(3i)']}")
   end_date =  Date.parse("#{params[:deactivate_slot]['to_date(1i)']}/#{params[:deactivate_slot]['to_date(2i)']}/#{params[:deactivate_slot]['to_date(3i)']}") # strat_end and end_date (leave from - to )

    doctor = Doctor.find(params[:deactivate_slot][:doctor_id])
  	dt1 = Time.parse(doctor.doctor_profile.working_from.to_s)
    dt2 = Time.parse(doctor.doctor_profile.working_to.to_s)
    slots = calculate_time_slots(dt1 , dt2) # this is to find out doctor working slots (previously stroed in doctor_working_slot)
    free_slots = []
    slots.each do |slot|
    	unless params[:time_slots].include?(slot)
    		free_slots << slot  # this is to find out free slot (uncheck slot)
    	end
   	end

   for date in  start_date..end_date # for from start_date to end_date
   	 free_slots.each do |free_slot|  # for each slot in free_slots
   	    DeactivateSlot.create( :doctor_id => doctor.id , :from_date => date, :time_from => free_slot, :reason_for_absence => params[:deactivate_slot][:reason_for_absence] )
  	 end
   end
   flash[:notice] = 'DeactivateSlot was successfully created.'
   redirect_to(cms_deactivate_slots_url())

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

  def time_slot
  	doctor = Doctor.find(params[:doctor_id])
  	dt1 = Time.parse(doctor.doctor_profile.working_from.to_s)
    dt2 = Time.parse(doctor.doctor_profile.working_to.to_s)
    @timing_slot = calculate_time_slots(dt1 ,dt2)
    @working_slots = doctor.doctor_working_slots.map {|ob| Time.parse(ob.slot.to_s).strftime("%H:%M") }
    render :update do |page|
      page.replace_html 'working_slot', :partial => 'cms/deactivate_slots/timing_slots'
    end
 	end

  def destroy
    @deactivate_slot = DeactivateSlot.find(params[:id])
    @deactivate_slot.destroy
    redirect_to(cms_deactivate_slots_url())
  end

  private

  def calculate_time_slots(dt1 ,dt2)
  	slot = []
  	count = ((((dt2 - dt1))/60)/60).to_i
    count.times do
       slot << "#{(dt1.strftime('%H:%M').to_s)} - #{(dt1 = dt1 + 60.minutes).strftime('%H:%M').to_s}"
    end
    remain_min =  ((dt2 - dt1)/60)
    slot << "#{(dt1.strftime('%H:%M').to_s)} - #{(dt1 = dt1 + remain_min.minutes).strftime('%H:%M').to_s}"
    return slot

 	end

end
