class CreatePharmacyCourseLists < ActiveRecord::Migration
  def self.up
    create_table :pharmacy_course_lists do |t|
      t.string :course_type_name

      t.timestamps
    end
  end

  def self.down
    drop_table :pharmacy_course_lists
  end
end
