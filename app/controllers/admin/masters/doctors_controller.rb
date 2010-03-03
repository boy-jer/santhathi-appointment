class Admin::Masters::DoctorsController < ApplicationController
    layout proc{ |c| ['show','new', 'create', 'edit'].include?(c.action_name)? 'admin_single_column' : 'admin'}

  def index
    @search = Doctor.new_search(params[:search])
    @search.per_page ||= 15
    @doctors = @search.all
    respond_to do |format|
              format.html
              format.js {
                      render :update do |page|
                        page.replace_html 'doctor-list', :partial => 'doctors_list'
                      end
                      }
              end
  end

  def show
    @doctor = Doctor.find(params[:id])
  end

  def new
    @doctor = Doctor.new
    @doctor.build_doctor_profile
  end

  def edit
    @doctor = Doctor.find(params[:id])
    @timing_slot = []
    @working_slots = @doctor.doctor_working_slots.map {|ob| Time.parse(ob.start_time.to_s).strftime("%H:%M") }
    dt1 = Time.parse(@doctor.doctor_profile.working_from.to_s)
    dt2 = Time.parse(@doctor.doctor_profile.working_to.to_s)
    @timing_slot = calculate_time_slots(dt1 ,dt2)
  end

  def create
    @doctor = Doctor.new(params[:doctor])
    if @doctor.save
     #@doctor.doctor_profile.create(params[:doctor][:doctor_profile])
      @doctor.register!
      @doctor.active!
      @doctor.roles << Role.find_by_name('doctor')
      unless params[:time_slots].blank?
    	DoctorWorkingSlot.transaction do
    	  params[:time_slots].each do |time_slot|
    	    dt1 = Time.parse("#{time_slot.split("-").first}:00")
    	    dt2 = Time.parse("#{time_slot.split("-").last}:00")
    	    slots = calculate_slots(dt1 , dt2)
            DoctorWorkingSlot.create({:doctor_id => @doctor.id ,:start_time => time_slot ,:slots => slots })
          end
         end
       end
       flash[:notice] = 'Doctor record is successfully created.'
       redirect_to(admin_masters_doctors_url)
    else
      render :action => "new"
    end
  end

  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update_attributes(params[:doctor])
      flash[:notice] = 'Doctor was successfully updated.'
      unless params[:time_slots].blank?
         DoctorWorkingSlot.delete_all(["doctor_id = ? ",@doctor.id]) # deleting all rows in on query (little bit faster)
         #@doctor.doctor_working_slots.map { |p| p.destroy } # executing more queries than delete_all
    		 DoctorWorkingSlot.transaction do
    		 	 params[:time_slots].each do |time_slot|
    		 	   dt1 = Time.parse("#{time_slot.split("-").first}:00")
    		 	   dt2 = Time.parse("#{time_slot.split("-").last}:00")
    		 	   slots = calculate_slots(dt1 , dt2)
             DoctorWorkingSlot.create({:doctor_id => @doctor.id ,:start_time => time_slot ,:slots => slots })
           end
         end
  		end
     redirect_to(admin_masters_doctors_url)
     else
        render :action => "edit"
     end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.doctor_profile.destroy
    @doctor.destroy
    redirect_to(admin_masters_doctors_url)
  end

  def activate
    @doctor = Doctor.find(params[:id])
    @doctor.activate!
    redirect_to admin_masters_doctos_path
  end

  def working_slots
    strt_hr, strt_mnt, end_hr, end_mint = params[:sth].to_i, params[:stm].to_i, params[:eth].to_i, params[:etm].to_i
    dt1 = Time.parse("#{strt_hr}:#{strt_mnt}:00")
    dt2 = Time.parse("#{end_hr}:#{end_mint}:00")

    @timing_slot  = calculate_time_slots(dt1, dt2)

    render :update do |page|
      page.replace_html 'working_slot', :partial => 'admin/masters/doctors/working_slots'
    end
  end

  private

  def calculate_slots(dt1 ,dt2)
    slots = []
    while(dt1< dt2)
      slots << "#{dt1.strftime('%H:%M').to_s}"
      dt1 += TIMING_SLOT.minutes
    end
    return slots
  end

  def calculate_time_slots(dt1 ,dt2)
  	slot = []
  	count = ((((dt2 - dt1))/60)/30).to_i
    count.times do
      slot << "#{(dt1.strftime('%H:%M').to_s)}-#{(dt1 = dt1 + 30.minutes).strftime('%H:%M').to_s}"
    end
    remain_min =  ((dt2 - dt1)/30)
    if remain_min != 0.0
      slot << "#{(dt1.strftime('%H:%M').to_s)}-#{(dt1 = dt1 + remain_min.minutes).strftime('%H:%M').to_s}"
    end
    return slot

  end


end

