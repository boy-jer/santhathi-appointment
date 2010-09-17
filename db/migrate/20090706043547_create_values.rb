class CreateValues < ActiveRecord::Migration
  def self.up
    create_table :parameter_values do |t|
    	t.integer :parameter_id
    	t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :values
  end
end
