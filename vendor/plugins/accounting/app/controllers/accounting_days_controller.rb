class AccountingDaysController < ApplicationController
  layout 'accounting'
  skip_before_filter :require_current_day, :only => [:new, :create, :re_open]
  before_filter :require_no_current_day, :only => [:new, :create, :re_open]

  def new
    @accounting_day = user_default_branch.accounting_days.build
    @last_closed_day = user_default_branch.closed_accounting_days.last(:conditions => "accounting_period_id = #{current_accounting_period.id}", :order => 'closed_at')
  end

  def create
    @accounting_day = user_default_branch.accounting_days.build(params[:accounting_day])
    if @accounting_day.save 
      redirect_to accounts_path
    else
      @last_closed_day = user_default_branch.closed_accounting_days.last(:conditions => "accounting_period_id = #{current_accounting_period.id}", :order => 'closed_at')
      render :action => 'new'
    end
  end

  def close    
    if request.put?
      current_day.close!
      redirect_to accounts_path
    end
  end

  def re_open
    @last_closed_day = user_default_branch.closed_accounting_days.last(:conditions => "accounting_period_id = #{current_accounting_period.id}", :order => 'closed_at')
    @last_closed_day.re_open!
    redirect_to accounts_path
  end

  protected

  def require_no_current_day
    redirect_to accounts_path unless current_day.blank?
  end
end
