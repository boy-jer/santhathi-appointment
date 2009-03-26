class DoctorPatientsController < ApplicationController
   layout 'cms'
  # GET /doctor_appointments
  # GET /doctor_appointments.xml
  def index
  
  respond_to do |format|
      format.html {  @appointments = Appointment.visited_and_discharge_recomonded('visited', 'recommend_for_discharge').paginate(:per_page => 10, :page => params[:page])
                  }
      format.js   { if params.has_key?(:pname) #Search request via ajax call
                      search = 'Appointment'
                      search = search + '.on_date(Time.parse(params[:date]).to_date)' unless params[:date].blank?
                      search = search + '.doctor_name(params[:doctor][:id])' unless params[:doctor][:id].blank?
                      search = search + '.patient_name(params[:pname])' unless params[:pname].blank?
                      search = search + '.reg_no(params[:rnum])' unless params[:rnum].blank?

                      unless search == 'Appointment' #if no search parameters provided, return all.
                        @appointments = eval(search).paginate(:all, :order => 'appointment_date DESC', :per_page => 10, :page => params[:page])
                      else
                        @appointments = Appointment.paginate(:all, :order => 'appointment_date DESC', :per_page => 10, :page => params[:page])
                      end

                      render :update do |page|
                        page.replace_html 'appointment-list', :partial => 'patient_list'
                      end

                    else #Appointments list request via ajax call for a doctor
                      @doctor = Doctor.find(params[:doctor]) unless params[:doctor].blank?
                      @date = Date.parse(params[:date])
                      render :update do |page|
                        page.replace_html 'schedule', :partial => 'appointments_detail', :locals => {:doctor => @doctor, :date =>@date}
                      end
                    end
                  }
    end
  end
  
  def discharge
    date = (Date.parse(params[:date]) unless params[:date].blank?) || Date.today
    appointments = Appointment.on_date(date).status('visited') 
    appointments.map {|appointment| appointment.discharge!}
    redirect_to doctor_patients_path
  end
  
  def update
    unless params[:appointment].blank?
      params[:appointment].map{ |id| appointment = Appointment.find(id)
                                appointment.recommend_for_discharge! unless (appointment.blank? && appointment.visited?)}
      redirect_to doctor_patients_path
    else
      flash[:notice]=" Please select at least one appointment."
      redirect_to doctor_patients_path
    end 
  end

  def clinical_screen
    unless params[:id].blank?
       @appointment = Appointment.find(params[:id]) 
       @patient = @appointment.patient
       @doctor = @appointment.doctor
       @departments = Department.find(:all)
       #@age = Date.today - @patient.dob
    else
      flash[:notice]=" Please select at least one appointment."
      redirect_to doctor_patients_path
    end 
  end  

end

