class AccountGroupsController < ApplicationController
  layout 'accounting'

  def index
    @account_group_types = user_default_branch.account_group_types.find(:all, :include => :account_groups)
  end

  def new
    @account_group = user_default_branch.account_groups.build
    @income_group_type = user_default_branch.account_group_types.find_by_name('Income')
    @income_main_groups = @income_group_type.main_account_groups

    @expense_group_type = user_default_branch.account_group_types.find_by_name('Expense')
    @expense_main_groups = @expense_group_type.main_account_groups

    @liability_group_type = user_default_branch.account_group_types.find_by_name('Liabilities')
    @liability_main_groups = @liability_group_type.main_account_groups

    @asset_group_type = user_default_branch.account_group_types.find_by_name('Assets')
    @asset_main_groups = @asset_group_type.main_account_groups
  end

  def create
    if params[:account_group][:parent_id].blank?
      @account_group = user_default_branch.account_main_groups.build(params[:account_group])
    else
      @account_group = user_default_branch.account_sub_groups.build(params[:account_group])
    end
    @account_group.account_group_type_id = user_default_branch.account_group_types.find(params[:account_group][:account_group_type_id]).id unless params[:account_group][:account_group_type_id].blank?
    @account_group.parent_id = @account_group.account_group_type.account_groups.find(params[:account_group][:parent_id]).id unless params[:account_group][:parent_id].blank?
    if @account_group.save
      flash[:notice] = "Account Group saved successfully"
      redirect_to account_groups_path
    else
      @income_group_type = user_default_branch.account_group_types.find_by_name('Income')
      @income_main_groups = @income_group_type.main_account_groups

      @expense_group_type = user_default_branch.account_group_types.find_by_name('Expense')
      @expense_main_groups = @expense_group_type.main_account_groups

      @liability_group_type = user_default_branch.account_group_types.find_by_name('Liabilities')
      @liability_main_groups = @liability_group_type.main_account_groups

      @asset_group_type = user_default_branch.account_group_types.find_by_name('Assets')
      @asset_main_groups = @asset_group_type.main_account_groups
      render :action => 'new'
    end
  end
end
