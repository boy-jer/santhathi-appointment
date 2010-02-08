class Pos::BillsController < ApplicationController
  layout 'pms'

  def index
    @bills = Payment.all
  end
end
