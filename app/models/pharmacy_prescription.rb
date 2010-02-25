class PharmacyPrescription < ActiveRecord::Base
  belongs_to :appointment
  #belongs_to :pharamacy_item_information
  belongs_to :pharmacy_course_list
  belongs_to :pharmacy_dosage_list
  belongs_to :inventory_item
  validates_presence_of :inventory_item_id, :pharmacy_course_list_id, :pharmacy_dosage_list_id, :course_start_date, :course_end_date
end
