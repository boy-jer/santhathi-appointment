class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :name
      t.string :description
      t.string :cost
      t.string :first_visit
      t.string :follow_up_visit
      t.integer :department_id
      t.integer :parent_id
      t.integer :depth
      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
