class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      t.string :dept_name
      t.string :abbrevation
      t.string :description
      t.string :system_defined

      t.timestamps
    end
  end

  def self.down
    drop_table :departments
  end
end
