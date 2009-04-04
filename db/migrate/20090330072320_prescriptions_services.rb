class PrescriptionsServices < ActiveRecord::Migration
  def self.up
    create_table :prescriptions_services do |t|
      t.integer :prescription_id
      t.integer :service_id
    end
  end

  def self.down
    drop_table :prescriptions_services
  end
end
