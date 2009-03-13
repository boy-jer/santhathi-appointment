class CreatePharmacyDosageLists < ActiveRecord::Migration
  def self.up
    create_table :pharmacy_dosage_lists do |t|
      t.string :dosage_type_name

      t.timestamps
    end
  end

  def self.down
    drop_table :pharmacy_dosage_lists
  end
end
