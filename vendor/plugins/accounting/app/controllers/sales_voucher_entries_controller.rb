class SalesVoucherEntriesController < ApplicationController
  layout 'accounting'

  def new
    @sales_accounts = user_default_branch.accounts.sales_accounts
    @all_accounts = user_default_branch.accounts.non_sales_accounts
    @sales_voucher_entry = user_default_branch.sales_voucher_entries.build
  end

  def create
    @sales_voucher_entry = user_default_branch.sales_voucher_entries.build(params[:sales_voucher_entry])
    if @sales_voucher_entry.save
      redirect_to new_sales_voucher_entry_path
    else
      @sales_accounts = user_default_branch.accounts.sales_accounts
      @all_accounts = user_default_branch.accounts.non_sales_accounts
      render :action => 'new'
    end
  end

  def show
    @sales_voucher_entry = user_default_branch.sales_voucher_entries.find(params[:id])
    @sales_credit_item = @sales_voucher_entry.credit_transaction_item
    @sales_debit_items = @sales_voucher_entry.debit_transaction_items
  end
end
