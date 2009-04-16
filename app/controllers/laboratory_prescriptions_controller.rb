class LaboratoryPrescriptionsController < ApplicationController
  layout 'laboratory'

  def index
     @prescriptions = Prescription.find(:all, :order => 'p_date')
  end



end
