class CreateRegistrationSummaries < ActiveRecord::Migration
  def self.up
    create_table :registration_summaries do |t|
      t.string :registration_summary
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :registration_summaries
  end
end
