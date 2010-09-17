class PurchaseVoucherEntriesController < ApplicationController
  layout 'accounting'

  def new
    @purchase_accounts = user_default_branch.accounts.purchase_accounts
    @all_accounts = user_default_branch.accounts.non_purchase_accounts
    @all_inventory_items = user_default_branch.inventory_items
    @purchase_voucher_entry = user_default_branch.purchase_voucher_entries.build
  end

  def create
    @purchase_voucher_entry = user_default_branch.purchase_voucher_entries.build(params[:purchase_voucher_entry])
    if @purchase_voucher_entry.save
      redirect_to new_purchase_voucher_entry_path
    else
      @purchase_accounts = user_default_branch.accounts.purchase_accounts
      @all_accounts = user_default_branch.accounts.non_purchase_accounts
      @all_inventory_items = user_default_branch.inventory_items
      render :action => 'new'
    end
  end

  def show
    @purchase_voucher_entry = user_default_branch.purchase_voucher_entries.find(params[:id])
    @purchase_credit_items = @purchase_voucher_entry.credit_transaction_items
    @purchase_debit_item = @purchase_voucher_entry.debit_transaction_item
  end
end
