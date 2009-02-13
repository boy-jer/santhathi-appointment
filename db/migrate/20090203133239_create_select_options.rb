class CreateSelectOptions < ActiveRecord::Migration
  def self.up
    create_table :select_options do |t|
      t.string :name
      t.string :type
      t.string :abbrevation
      t.integer :position
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :select_options
  end
end
