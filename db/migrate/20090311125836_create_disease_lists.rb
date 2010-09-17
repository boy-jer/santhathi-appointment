class CreateDiseaseLists < ActiveRecord::Migration
  def self.up
    create_table :disease_lists do |t|
      t.string :disease
      t.string :icd_code
      t.string :family_history
      t.string :immunization
      t.string :med_history
      t.string :gyno_history
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :disease_lists
  end
end
