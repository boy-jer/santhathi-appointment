class PatientsController < ApplicationController
  layout 'pms'
  # GET /patients
  # GET /patients.xml
  def index
    @patients = Patient.paginate(:all, :per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @patients }
    end
  end

  # GET /patients/1
  # GET /patients/1.xml
  def show
    @patient = Patient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patient }
      format.js { render :layout => false }
    end
  end

  # GET /patients/new
  # GET /patients/new.xml
  def new
    @patient = Patient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/1/edit
  def edit
    #@partail = 'individual'
    @patient = Patient.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patient }
      format.js {
                 @patient1 = @patient.spouse.blank? ? Patient.new : Patient.find(@patient.spouse)
                 render :update do |page|
                   page.replace_html 'couple_fields', :partial => 'couple'
                 end
               }
   end
  end

  # POST /patients
  # POST /patients.xml
  def create
    @patient1 = Patient.new(params[:patient])
    @patient2 = Patient.new(params[:patient1])
    respond_to do |format|
      if @patient.save && @patient2.save
        flash[:notice] = 'Patient was successfully created.'
        format.html { redirect_to(patients_path) }
        format.xml  { render :xml => @patient, :status => :created, :location => @patient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patients/1
  # PUT /patients/1.xml
  def update
    patient1 = Patient.find(params[:id])
    patient2 = patient1.spouse.blank? ? Patient.new(params[:patient1]) : Patient.find(patient1.spouse)
    patient1.update_attribute('reg_no',patient1.generate_reg_no)
    respond_to do |format|
      if patient1.update_attributes(params[:patient]) && patient2.update_attributes(params[:patient1])
      	patient1.spouse = patient2.id
      	patient2.spouse = patient1.id
      	patient1.spouse_name = patient2.patient_name
      	patient2.spouse_name = patient1.patient_name
      	patient1.save
      	patient2.generate_reg_no
      	patient2.reg_date = Time.now
      	if patient1.gender == "m"
      	   patient2.gender = "f"
     	else
     	  patient2.gender = "m"
    	end
    	patient2.address = patient1.address
      	patient2.save


        flash[:notice] = 'Patient was successfully updated.'
        format.html { redirect_to(patients_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => patient1.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.xml
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to(patients_url) }
      format.xml  { head :ok }
    end
  end
end
