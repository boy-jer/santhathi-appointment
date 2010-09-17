class CreatePaymentItems < ActiveRecord::Migration
  def self.up
    create_table :payment_items do |t|
      t.references :payment
      t.references :payable, :polymorphic => true
      t.integer :quantity
      t.decimal :amount, :precision => 11, :scale => 2
      t.decimal :total_amount, :precision => 11, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :payment_items
  end
end
