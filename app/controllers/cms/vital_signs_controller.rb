class  Cms::VitalSignsController < ApplicationController
  before_filter :find_patient, :only => [:new, :create,:edit ]

  def new
    @registration_summaries = RegistrationSummary.find(:all)
    render :layout => false
  end

  def edit
    @all_summaries = {}
    @all_summaries= RegistrationSummary.find(:all).map{|reg|  [reg.id , reg.name]  }
    @vital_signs = @patient.vital_signs
    render :layout => false
  end

  def create
  	params[:vital_signs].each {  |key, value|
  		             @patient.vital_signs.create(:registration_summary_id=>"#{key}",:value=>"#{value}")
                              }
    flash[:notice] = 'VitalSign was successfully created.'
    redirect_to cms_doctor_patients_path(current_user.id)
  end

  def update
    patient = Patient.find_by_id(params[:id])
    patient.vital_signs.map { |vital_sign| vital_sign.destroy}
    params[:vital_signs].each {  |key, value|
                  patient.vital_signs.create(:registration_summary_id=>"#{key}",:value=>"#{value}")
                             }
    flash[:notice] = 'VitalSign was successfully updated.'
     redirect_to cms_doctor_patients_path(current_user.id)
  end

  private

 	def find_patient
		@patient = Patient.find_by_id(params[:patient_id])
	end

end
