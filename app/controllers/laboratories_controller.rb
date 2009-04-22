class LaboratoriesController < ApplicationController
 layout	'laboratory'

  def index
    redirect_to prescriptions_url
  end

end
