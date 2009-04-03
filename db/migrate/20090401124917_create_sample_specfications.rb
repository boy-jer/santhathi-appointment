class CreateSampleSpecfications < ActiveRecord::Migration
  def self.up
    create_table :sample_specfications do |t|
      t.integer :age_group_from
      t.integer :age_group_to
      t.string :specimen
      t.string :volume
      t.string :min_volume
      t.string :sample_for
      t.string :collection_proedure
      t.string :specimen_condition
      t.string :container_type
      t.string :storage_instructions
      t.integer :lab_test_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sample_specfications
  end
end
