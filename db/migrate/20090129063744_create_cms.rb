class CreateCms < ActiveRecord::Migration
  def self.up
    create_table :cms do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :cms
  end
end
