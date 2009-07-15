class Pms::DoctorsController < ApplicationController
  layout 'pms'

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
    @working_slots = @doctor.doctor_working_slots.map {|ob| Time.parse(ob.slot.to_s).strftime("%H:%M") }
    dt1 = Time.parse(@doctor.doctor_profile.working_from.to_s)
    dt2 = Time.parse(@doctor.doctor_profile.working_to.to_s)
    @timing_slot = calculate_time_slots(dt1 ,dt2)
  end

  def create
    @doctor = Doctor.new(params[:doctor])
    if @doctor.save
      # @doctor.doctorrofile.create(params[:doctor][:doctor_profile])
      @doctor.register!
      @doctor.activate!
      @doctor.roles << Role.find_by_name('doctor')
      unless params[:time_slots].blank?
    		 DoctorWorkingSlot.transaction do
    		 	 params[:time_slots].each do |slot|
              DoctorWorkingSlot.create({:doctor_id => @doctor.id ,:slot => slot})
           end
         end
  		end
  		flash[:notice] = 'Doctor was successfully created.'
      redirect_to(pms_doctors_url)
    else
      render :action => "new"
    end
  end

  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update_attributes(params[:doctor])
      flash[:notice] = 'Doctor was successfully updated.'
       unless params[:time_slots].blank?
         @doctor.doctor_working_slots.map {|ob| ob.destroy }
    	 DoctorWorkingSlot.transaction do
    	   params[:time_slots].each do |slot|
             DoctorWorkingSlot.create({:doctor_id => @doctor.id, :slot => slot})
           end
         end
       end
     redirect_to(pms_doctors_url)
     else
        render :action => "edit"
     end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.doctor_profile.destroy
    @doctor.destroy
    redirect_to(pms_doctors_url)
  end

  def activate
    @doctor = Doctor.find(params[:id])
    @doctor.activate!
    redirect_to pms_doctos_path
  end

  def working_slots
    strt_hr, strt_mnt, end_hr, end_mint = params[:sth].to_i, params[:stm].to_i, params[:eth].to_i, params[:etm].to_i
    dt1 = Time.parse("#{strt_hr}:#{strt_mnt}:00")
    dt2 = Time.parse("#{end_hr}:#{end_mint}:00")
    @timing_slot  = calculate_time_slots(dt1, dt2)

    render :update do |page|
      page.replace_html 'working_slot', :partial => 'pms/doctors/working_slots'
    end
  end

  private

  def calculate_time_slots(dt1 ,dt2)
  	slot = []
  	count = ((((dt2 - dt1))/60)/60).to_i
    count.times do
      slot << "#{(dt1.strftime('%H:%M').to_s)}-#{(dt1 = dt1 + 60.minutes).strftime('%H:%M').to_s}"
    end
    remain_min =  ((dt2 - dt1)/60)
    slot << "#{(dt1.strftime('%H:%M').to_s)}-#{(dt1 = dt1 + remain_min.minutes).strftime('%H:%M').to_s}"
    return slot

 	end


end
