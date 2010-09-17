class Pos::BillsController < ApplicationController
  layout 'pms_single_column'

  def index
    @search = Payment.new_search(params[:search])
    @params = params[:search]
    @search.per_page ||= 25
    @search.order_as ||= "DESC"
    @search.order_by ||= "created_at"
    @bills = @search.all
  end
end
