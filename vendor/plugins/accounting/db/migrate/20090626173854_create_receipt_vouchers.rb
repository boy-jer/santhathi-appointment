class CreateReceiptVouchers < ActiveRecord::Migration
  def self.up
    create_table :receipt_vouchers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :receipt_vouchers
  end
end
