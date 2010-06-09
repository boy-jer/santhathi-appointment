class AddSpouseIdToPatient < ActiveRecord::Migration
  def self.up
    add_column :patients, :spouse_id, :integer
  end

  def self.down
  end
end
