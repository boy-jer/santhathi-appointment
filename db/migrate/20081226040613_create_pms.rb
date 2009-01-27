class CreatePms < ActiveRecord::Migration
  def self.up
    create_table :pms do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :pms
  end
end
