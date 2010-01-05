class JournalVoucherEntriesController < ApplicationController
  layout 'accounting'

  def new
    @non_cash_bank_accounts = user_default_branch.accounts.non_bank_cash_accounts
    @journal_voucher_entry = user_default_branch.journal_voucher_entries.build
  end

  def create
    @journal_voucher_entry = user_default_branch.journal_voucher_entries.build(params[:journal_voucher_entry])
    if @journal_voucher_entry.save
      redirect_to new_journal_voucher_entry_path
    else
    @non_cash_bank_accounts = user_default_branch.accounts.non_bank_cash_accounts
      render :action => 'new'
    end
  end

  def show
    @journal_voucher_entry = user_default_branch.journal_voucher_entries.find(params[:id])
    @journal_transaction_items = @journal_voucher_entry.account_transaction_items
  end
end
