class LaboratoryPrescriptionsController < ApplicationController
  layout 'laboratory'

  def index
	 @appointment = Appointment.find(:all)
  end



end
