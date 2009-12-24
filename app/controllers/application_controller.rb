# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include RoleRequirementSystem
 # include FaceboxRender

  helper :all # include all helpers, all the time
  filter_parameter_logging :password, :password_confirmation
  helper_method :s, :current_company, :user_default_branch, :current_day, :current_accounting_period
  before_filter :require_current_accounting_period, :require_current_day

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9fe6825f97cc334d88925fde5c4808a8'

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

  ########### Accounts related

  def user_default_branch
    return @user_default_branch if defined?(@user_default_branch)
    company = Company.find_by_name('Santhathi')
    @user_default_branch = company.branches.find_by_name('Main')
  end

  def current_company
    return @current_company if defined?(@current_company)    
    @current_company = Company.find_by_name('Santhathi')
  end

  def current_day
    return @current_day if defined?(@current_day)    
    @current_day = user_default_branch.default_current_open_day
  end

  def current_accounting_period
    return @current_accounting_period if defined?(@current_accounting_period)
    @current_accounting_period = user_default_branch.current_accounting_period
  end

  def require_current_day
    redirect_to new_accounting_day_path if current_day.blank?
  end

  def require_current_accounting_period
    redirect_to new_accounting_period_path if current_accounting_period.blank?
  end
  #################
end
