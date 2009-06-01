class PharamacyItemInformationDetail < ActiveRecord::Base
  belongs_to :pharamacy_item_information
	belongs_to :pharmacy_course_list
	belongs_to :pharmacy_dosage_list
end
