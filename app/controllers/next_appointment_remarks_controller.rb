class NextAppointmentRemarksController < ApplicationController
 layout 'cms'

  def index
    @next_appointment_remarks = NextAppointmentRemark.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @next_appointment_remarks }
    end
  end


  def show
    @next_appointment_remark = NextAppointmentRemark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @next_appointment_remark }
    end
  end


  def new
  	nar =  NextAppointmentRemark.find_by_appointment_id(params[:appointment_id])
  	redirect_to edit_appointment_next_appointment_remark_path(:appointment_id => nar.appointment_id,:id=> nar.id) unless nar.blank?
  	@appointment = Appointment.find(params[:appointment_id])
    @next_appointment_remark = NextAppointmentRemark.new

  end


  def edit
    @next_appointment_remark = NextAppointmentRemark.find(params[:id])
    respond_to do |format|
      format.js { render :layout => false }
    end
  end


  def create
    @appointment = Appointment.find(params[:appointment_id])
   # @next_appointment_remark = @appointment.next_appointment_remark.create(params[:next_appointment_remark])

    @next_appointment_remark  = NextAppointmentRemark.new(params[:next_appointment_remark])
    @next_appointment_remark.appointment = @appointment

    respond_to do |format|
      if @next_appointment_remark.save
        flash[:notice] = 'NextAppointmentRemark was successfully created.'
        format.html { redirect_to(new_appointment_clinical_screen_path(@appointment))  }
        format.xml  { render :xml => @next_appointment_remark, :status => :created, :location => @next_appointment_remark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @next_appointment_remark.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
  	@appointment = Appointment.find(params[:appointment_id])
    @next_appointment_remark = NextAppointmentRemark.find(params[:id])

    respond_to do |format|
      if @next_appointment_remark.update_attributes(params[:next_appointment_remark])
        flash[:notice] = 'NextAppointmentRemark was successfully updated.'
        format.html { redirect_to(new_appointment_clinical_screen_path(@appointment)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @next_appointment_remark.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @next_appointment_remark = NextAppointmentRemark.find(params[:id])
    @next_appointment_remark.destroy

    respond_to do |format|
      format.html { redirect_to(next_appointment_remarks_url) }
      format.xml  { head :ok }
    end
  end



end
