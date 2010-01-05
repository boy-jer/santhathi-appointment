class ReceiptVoucherEntriesController < ApplicationController
  layout 'accounting'

  def new
    @cash_bank_accounts = user_default_branch.accounts.bank_cash_accounts
    @all_accounts = user_default_branch.accounts.non_bank_cash_accounts
    @receipt_voucher_entry = user_default_branch.receipt_voucher_entries.build
  end

  def create
    @receipt_voucher_entry = user_default_branch.receipt_voucher_entries.build(params[:receipt_voucher_entry])
    if @receipt_voucher_entry.save
      redirect_to new_receipt_voucher_entry_path
    else
      @cash_bank_accounts = user_default_branch.accounts.bank_cash_accounts
      @all_accounts = user_default_branch.accounts.non_bank_cash_accounts
      render :action => 'new'
    end
  end

  def show
    @receipt_voucher_entry = user_default_branch.receipt_voucher_entries.find(params[:id])
    @receipt_credit_items = @receipt_voucher_entry.credit_transaction_items
    @receipt_debit_item = @receipt_voucher_entry.debit_transaction_item
  end
end
