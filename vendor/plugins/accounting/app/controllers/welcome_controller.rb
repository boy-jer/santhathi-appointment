class WelcomeController < ApplicationController
  layout 'accounting'
  skip_before_filter :require_user, :require_current_day
  
  def index
  end

end
