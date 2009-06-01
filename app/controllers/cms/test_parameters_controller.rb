class Cms::TestParametersController < ApplicationController
  layout 'laboratory'

  def index
    department = Department.find_by_dept_name('Laboratory')
  end
end
