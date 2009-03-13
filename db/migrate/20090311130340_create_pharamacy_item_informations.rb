class CreatePharamacyItemInformations < ActiveRecord::Migration
  def self.up
    create_table :pharamacy_item_informations do |t|
      t.string :item_name
      t.string :item_code
      t.string :uom
      t.string :category_name
      t.string :user_sku

      t.timestamps
    end
  end

  def self.down
    drop_table :pharamacy_item_informations
  end
end
