class PharmacyPrescription < ActiveRecord::Base
	belongs_to :appointment
	#belongs_to :pharamacy_item_information
	belongs_to :pharmacy_course_list
	belongs_to :pharmacy_dosage_list
	belongs_to :inventory_item
end
