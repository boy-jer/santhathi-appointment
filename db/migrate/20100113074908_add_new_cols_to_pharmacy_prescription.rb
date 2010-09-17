class AddNewColsToPharmacyPrescription < ActiveRecord::Migration
  def self.up
    add_column :pharmacy_prescriptions, :inventory_item_id, :integer
    remove_column :pharmacy_prescriptions, :pharamacy_item_information_id
  end

  def self.down
    remove_column :pharmacy_prescriptions, :inventory_item_id
    add_column :pharmacy_prescriptions, :pharamacy_item_information_id, :integer
  end
end
