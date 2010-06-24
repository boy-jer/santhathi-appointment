class Pms::PatientsController < ApplicationController
  layout proc{ |c| ['show','new', 'create', 'edit','associate_couple', 'report'].include?(c.action_name)? 'pms_single_column' : 'pms'}

  def index
    @search = Patient.new_search(params[:search])
    @search.per_page ||= 5
    @patients = @search.all
    @search.order_as ||= "DESC"
    @search.order_by ||= "reg_no"
    
    respond_to do |format|
      format.html
       format.js {
                     render :update do |page|
                        page.replace_html 'patients-list', :partial => 'patients_list'
                      end
                 }
    end
  end

  def show
    @patient = Patient.find(params[:id])
    @appointments = @patient.appointments
  end

  def new
  	@patient = Patient.new
  	if params[:type] == '1'
      @patient1 = Patient.new
      @partial = 'couple'
    else
      @partial = 'individual'
    end
  end

  def edit
    @patient = Patient.find(params[:id])

    respond_to do |format|
      format.html
      format.js {
                  @patient1 = @patient.spouse.blank? ? Patient.new : Patient.find(@patient.spouse)
                  render :update do |page|
                    page.replace_html 'couple_fields', :partial => 'couple', :object => @patient1
                  end
                }
   end
  end

  def create
    @patient1 = Patient.new(params[:patient])
    @patient2 = Patient.new(params[:patient1]) unless params[:patient1].blank?
    @patient1.reg_date = Date.today
    @patient1.generate_reg_no
    if @patient1.save
    	unless params[:patient1].blank?
        @patient2.generate_reg_no
        if @patient1.gender == "male"
     	    @patient2.gender = "female"
   	    else
   	      @patient2.gender = "male"
   	    end
        @patient2.spouse  =  @patient1.id
        @patient1.spouse_name, @patient2.spouse_name = @patient2.patient_name, @patient1.patient_name
        @patient2.address = @patient1.address
        @patient2.reg_date = Date.today
        @patient2.save
        @patient1.spouse = @patient2.id
        @patient1.save
      end
      flash[:notice] = 'Patient was successfully created.'
      redirect_to pms_patients_url
    else
    	flash[:notice] = 'Please Enter all Fields '
      @partial = params[:partial]
      render :action => "new"
    end
  end

  def update
=begin
    @patient = Patient.find(params[:id])
    patient2 = @patient.spouse.blank? ? Patient.new(params[:patient1]) : Patient.find(@patient.spouse)
    @patient.generate_reg_no
    if @patient.update_attributes(params[:patient]) && patient2.update_attributes(params[:patient1])
     	@patient.spouse = patient2.id
      patient2.spouse = @patient.id
      @patient.spouse_name = patient2.patient_name
      patient2.spouse_name = @patient.patient_name
      @patient.save
      patient2.generate_reg_no
      patient2.reg_date = Time.now
      if @patient.gender == "male"
        patient2.gender = "female"
     	else
     	  patient2.gender = "male"
    	end
    	patient2.address = @patient.address
      patient2.save
      flash[:notice] = 'Patient was successfully updated.'
      redirect_to pms_patients_url
    else
      render :action => "edit"
    end
=end
    @patient = Patient.find(params[:id])
    patient2 = @patient.spouse.blank? ? Patient.new(params[:patient1]) : Patient.find(@patient.spouse) unless params[:patient1].blank?
    @patient.generate_reg_no if @patient.reg_no.blank?
    if @patient.update_attributes(params[:patient])
    	unless params[:patient1].blank?
    	   patient2.update_attributes(params[:patient1])
         patient2.spouse = @patient.id
         @patient.spouse_name = patient2.patient_name
         patient2.spouse_name = @patient.patient_name
         patient2.generate_reg_no
      	 patient2.reg_date = Time.now
         if @patient.gender == "male"
           patient2.gender = "female"
     	   else
     	     patient2.gender = "male"
    	   end
    	   patient2.address = @patient.address
         patient2.save
         @patient.spouse = patient2.id
         @patient.save
      end
      flash[:notice] = 'Patient was successfully updated.'
      redirect_to :pms_appointments
    else
      render :action => "edit"
    end
  end


  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    redirect_to(pms_patients_url)
  end


  def patient_search
    @patients = Patient.name_filter(params[:name])  unless params[:name].blank?
    @patients = Patient.contact_filter(params[:number])  unless params[:number].blank?
    @patients = Patient.reg_no_filter(params[:reg_num])  unless params[:reg_num].blank?
    render :update do |page|
      if params[:partial_form] == "left"
        page.replace_html params[:partial_form]+"_patient_search_results", :partial => "patient_search_results", :object => @patients
      else
        page.replace_html params[:partial_form]+"_patient_search_results", :partial => "spouse_search_results", :object => @patients
      end
    end
  end

  def associate_couple

  end


  def associate_spouse
    if !params[:spouse_id].blank? and !params[:patient_id].blank?
      patient = Patient.find(params[:patient_id])
      spouse =  Patient.find(params[:spouse_id])
      patient.spouse_name = spouse.patient_name
      patient.spouse = spouse.id
      spouse.spouse_name = patient.patient_name
      spouse.spouse = patient.id
      patient.save
      spouse.save
      flash[:notice] = 'Patient and Spouse Associated Successfuly .'
      redirect_to ( associate_couple_pms_patients_path() )
   else
     	flash[:notice] = 'Plaese Select  Patient and Spouse'
     	redirect_to ( associate_couple_pms_patients_path() )
   end
  end


  def report
    @appointment_object = Appointment.find(params[:appointment_id])
    if params[:report_type] == "visit"
      @appointment = Appointment.find(params[:appointment_id])
    elsif params[:report_type] == "pharamacy"
       @pharmacy_prescriptions = @appointment_object.pharmacy_prescriptions
    elsif params[:report_type] == "discharge_summary"
      @discharge_summary = @appointment_object.discharge_summary
    elsif params[:report_type] == "clinical_comment"
      @clinical_comment = @appointment_object.clinical_comment
    end
  end


end

