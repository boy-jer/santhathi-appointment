class DoctorAppointmentsController < ApplicationController
  layout 'cms'
  # GET /doctor_appointments
  # GET /doctor_appointments.xml
  def index
   doctor_id = (params[:doctor][:id] unless  params[:doctor].blank?) || (self.current_user.id if self.current_user.has_role?('admin'))
   @doctor = Doctor.find(doctor_id) unless doctor_id.blank?
   @date = (Date.parse(params[:date]) unless params[:date].blank?) || Date.today

   @appointments =  @doctor.appointments.on_date(@date) unless @doctor.blank?

   respond_to do |format|
      format.html # show.html.erb
      format.js  { render :update do |page|
                     if params[:filter] == '1'
                        page.replace_html 'appointment_list', :partial => 'appointment_list'
                     else
                        page.replace_html 'appointment_list', :partial => 'time_slots'
                     end  
                   end 
                 }
    end
  end

  # GET /doctor_appointments/1
  # GET /doctor_appointments/1.xml
  def show
    @doctor_appointment = DoctorAppointment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @doctor_appointment }
    end
  end

  # GET /doctor_appointments/new
  # GET /doctor_appointments/new.xml
  def new
    @doctor_appointment = DoctorAppointment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @doctor_appointment }
    end
  end

  # GET /doctor_appointments/1/edit
  def edit
    @doctor_appointment = DoctorAppointment.find(params[:id])
  end

  # POST /doctor_appointments
  # POST /doctor_appointments.xml
  def create
    @doctor_appointment = DoctorAppointment.new(params[:doctor_appointment])

    respond_to do |format|
      if @doctor_appointment.save
        flash[:notice] = 'DoctorAppointment was successfully created.'
        format.html { redirect_to(@doctor_appointment) }
        format.xml  { render :xml => @doctor_appointment, :status => :created, :location => @doctor_appointment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @doctor_appointment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /doctor_appointments/1
  # PUT /doctor_appointments/1.xml
  def update
    @doctor_appointment = DoctorAppointment.find(params[:id])

    respond_to do |format|
      if @doctor_appointment.update_attributes(params[:doctor_appointment])
        flash[:notice] = 'DoctorAppointment was successfully updated.'
        format.html { redirect_to(@doctor_appointment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @doctor_appointment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /doctor_appointments/1
  # DELETE /doctor_appointments/1.xml
  def destroy
    @doctor_appointment = DoctorAppointment.find(params[:id])
    @doctor_appointment.destroy

    respond_to do |format|
      format.html { redirect_to(doctor_appointments_url) }
      format.xml  { head :ok }
    end
  end
end
