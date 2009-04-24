class PatientsController < ApplicationController
  layout 'pms'
  # GET /patients
  # GET /patients.xml
  def index
  	@search = Patient.new_search(params[:search])
    @search.per_page = 20
    @patients, @patient_count = @search.all, @search.count
    respond_to do |format|
      format.html # index.html.erb
       format.js {
                      render :update do |page|
                        page.replace_html 'patients-list', :partial => 'patients_list'
                      end
                 }
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

  	if params[:type] == '1'
       @patient1 = Patient.new
       @partial = 'couple'
    else
        @partial = 'individual'
    end
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
    @patient1.reg_date = Date.today
    @patient1.generate_reg_no
    respond_to do |format|
      if @patient1.save && @patient2.save
      	   @patient2.generate_reg_no
      	   if @patient1.gender == "male"
      	  	  @patient2.gender = "female"
     	   else
     	      @patient2.gender = "male"
    	   end
      	   @patient1.spouse = @patient2.id
      	   @patient2.spouse = @patient1.id
      	   @patient1.spouse_name = @patient2.patient_name
           @patient2.spouse_name = @patient1.patient_name
           @patient2.address = @patient1.address
           @patient2.reg_date = Date.today
           @patient1.save
      	   @patient2.save
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
      	if patient1.gender == "male"
      	   patient2.gender = "female"
     	else
     	  patient2.gender = "male"
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

  def patient_search
    @patients = Patient.name_filter(params[:name]) unless params[:name].blank?
    render :update do |page|
        if params[:partial_form] == "left"
          page.replace_html params[:partial_form]+"_patient_search_results", :partial => "patient_search_results", :object => @patients
        else
          page.replace_html params[:partial_form]+"_patient_search_results", :partial => "spouse_search_results", :object => @patients
       end
    end
  end

  def associate_couple
  	#flash[:notice] =''

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
       	  flash[:notice] = 'Patient and Spouse Associated.'
          redirect_to (associate_couple_patients_path())
     else
     	flash[:notice] = 'Plaese Select  Patient and Spouse'
     	redirect_to (associate_couple_patients_path())
       end
  end



end
