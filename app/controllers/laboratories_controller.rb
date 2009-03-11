class LaboratoriesController < ApplicationController
 layout	'laboratory'

  def index
    @sub_tabs = {'Departments' => departments_url, "Doctors" => doctors_path}
  end

end
