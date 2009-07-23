#Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include RoleRequirementSystem
 #include ExceptionNotifiable
 # include FaceboxRender
  
  before_filter :login_require
  helper :all # include all helpers, all the time
  filter_parameter_logging :password, :password_confirmation
  

  # Return the value for a given setting
  def s(identifier)
    Setting.get(identifier)
  end

  def admin?
    #logged_in? && @current_user.has_role?(:admin)
  end

  def admin?
    logged_in? && current_user.has_role?(:admin)
  end

  def doctor?
    logged_in? && current_user.has_role?(:doctor)
  end
  helper_method :s

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9fe6825f97cc334d88925fde5c4808a8'

  private
  def login_require
    unless logged_in?
      redirect_to(login_url)
    end
  end
end
