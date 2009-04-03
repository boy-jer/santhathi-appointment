class CreateParameterSpecifications < ActiveRecord::Migration
  def self.up
    create_table :parameter_specifications do |t|

      t.integer :lab_test_id
      t.integer :parameter_id
      t.integer :age_group_from
      t.integer :age_group_to
      t.string :gender
      t.string :ideal_value
      t.string :min_value
      t.string :max_value
      t.string :special_condition


      t.timestamps
    end
  end

  def self.down
    drop_table :parameter_specifications
  end
end
