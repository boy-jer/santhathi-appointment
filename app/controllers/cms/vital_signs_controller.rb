class  Cms::VitalSignsController < ApplicationController
  before_filter :find_patient
  layout 'cms_single_column'

  def new
    @registration_summaries = RegistrationSummary.find(:all)
  end

  def edit
    @all_summaries = {}
    @all_summaries= RegistrationSummary.find(:all)
    @vital_signs = @patient.vital_signs
  end

  def create
  	params[:vital_signs].each {  |key, value|
  		             @patient.vital_signs.create(:registration_summary_id=>"#{key}",:value=>"#{value}")
                              }
    flash[:notice] = 'Registration summary is successfully created.'
    #redirect_to cms_doctor_patients_path(current_user.id)
    redirect_to edit_cms_vital_sign_path(:p => @patient.id, :id => 1)
  end

  def update

    @patient.vital_signs.map { |vital_sign| vital_sign.destroy}
    params[:vital_signs].each { |key, value|
                                @patient.vital_signs.create(:registration_summary_id=>"#{key}",:value=>"#{value}")
                              }
    flash[:notice] = 'Registration summary is successfully updated.'
     redirect_to :back
  end

  private

 	def find_patient
		@patient = Patient.find_by_id(params[:p])
	end

end

