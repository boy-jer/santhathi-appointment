class PaymentVoucherEntriesController < ApplicationController
  layout 'accounting'

  def new
    @cash_bank_accounts = user_default_branch.accounts.bank_cash_accounts
    @all_accounts = user_default_branch.accounts.non_bank_cash_accounts
    @payment_voucher_entry = user_default_branch.payment_voucher_entries.build
  end

  def create
    @payment_voucher_entry = user_default_branch.payment_voucher_entries.build(params[:payment_voucher_entry])
    if @payment_voucher_entry.save
      redirect_to new_payment_voucher_entry_path
    else
      @cash_bank_accounts = user_default_branch.accounts.bank_cash_accounts
      @all_accounts = user_default_branch.accounts.non_bank_cash_accounts
      render :action => 'new'
    end
  end

  def show
    @payment_voucher_entry = user_default_branch.payment_voucher_entries.find(params[:id])
    @payment_credit_item = @payment_voucher_entry.credit_transaction_item
    @payment_debit_items = @payment_voucher_entry.debit_transaction_items
  end
end
