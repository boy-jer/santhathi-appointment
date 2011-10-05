class AddRouteFrequencyQuantityDurationToInventoryItems < ActiveRecord::Migration
  def self.up
    add_column :inventory_items, :pharmacy_course_list_id, :integer
    add_column :inventory_items, :pharmacy_dosage_list_id, :integer
    add_column :inventory_items, :quantity, :integer
    add_column :inventory_items, :course_duration, :integer
    add_column :inventory_items, :other_remarks, :text
  end

  def self.down
    remove_column :inventory_items, :pharmacy_course_list_id
    remove_column :inventory_items, :pharmacy_dosage_list_id
    remove_column :inventory_items, :quantity
    remove_column :inventory_items, :course_duration
    remove_column :inventory_items, :other_remarks
  end
end
