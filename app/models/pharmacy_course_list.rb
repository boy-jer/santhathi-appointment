class PharmacyCourseList < ActiveRecord::Base
  has_one	:pharmacy_prescription
  has_one :pharamacy_item_information_detail

  def self.pharamacy_course_lists
    self.find(:all)
  end
end
