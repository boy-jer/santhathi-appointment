class CreateCmsPharamacyItemInformationDetails < ActiveRecord::Migration
  def self.up
    create_table :pharamacy_item_information_details do |t|

      t.integer :quantity
      t.integer :course_duration
      t.text :other_remarks
      t.references :pharamacy_item_information
      t.references :pharmacy_course_list
			t.references :pharmacy_dosage_list
      t.timestamps
    end
  end

  def self.down
    drop_table :pharamacy_item_information_details
  end
end
