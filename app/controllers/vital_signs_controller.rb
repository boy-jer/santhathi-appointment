class VitalSignsController < ApplicationController
  before_filter :find_patient, :only => [:new, :create,:edit]


   def new
    @registration_summaries = RegistrationSummary.find(:all)
    unless @patient.vital_signs.blank?
      	redirect_to edit_vital_sign_path(:id => 1, :patient_id => @patient.id)
    else
      respond_to do |format|
       format.js { render :layout => false }
      end
    end
  end


  def edit
  	   @all_summaries = {}
       @all_summaries= RegistrationSummary.find(:all).map{|reg|  [reg.id , reg.name]  }
       @vital_signs = @patient.vital_signs
  end


  def create
  	params[:vital_signs].each {  |key, value|
  		  @patient.vital_signs.create(:registration_summary_id=>"#{key}",:value=>"#{value}")

                              }
    respond_to do |format|
       flash[:notice] = 'VitalSign was successfully created.'
       format.html { redirect_to(doctor_patients_url) }
    end
  end


  def update
   patient = Patient.find_by_id(params[:id])
   patient.vital_signs.map { |vital_sign| vital_sign.destroy}
   params[:vital_signs].each {  |key, value|
                  patient.vital_signs.create(:registration_summary_id=>"#{key}",:value=>"#{value}")
                             }
    respond_to do |format|
      flash[:notice] = 'VitalSign was successfully updated.'
      format.html { redirect_to(doctor_patients_url) }
    end
  end


  private

	def find_patient
		@patient = Patient.find_by_id(params[:patient_id])
	end

end
