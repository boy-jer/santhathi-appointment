class ContraVoucherEntriesController < ApplicationController
  layout 'accounting'
  def new
    @cash_bank_accounts = user_default_branch.accounts.bank_cash_accounts
    @contra_voucher_entry = user_default_branch.contra_voucher_entries.build
  end

  def create
    @contra_voucher_entry = user_default_branch.contra_voucher_entries.build(params[:contra_voucher_entry])
    if @contra_voucher_entry.save
      redirect_to new_contra_voucher_entry_path
    else
      @cash_bank_accounts = user_default_branch.accounts.bank_cash_accounts
      render :action => 'new'
    end
  end

  def show
    @contra_voucher_entry = user_default_branch.contra_voucher_entries.find(params[:id])
    @contra_transaction_items = @contra_voucher_entry.account_transaction_items
  end
end
