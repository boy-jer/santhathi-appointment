class PharmacyDosageList < ActiveRecord::Base
	has_one	:pharmacy_prescription
	has_one :pharamacy_item_information_detail

	def self.pharamacy_dosage_lists
    self.find(:all)
  end

end
