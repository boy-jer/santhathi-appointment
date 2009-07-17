class DeactivateSlot < ActiveRecord::Base
  # validates_presence_of :reason_for_absence
  serialize :slots, Array
  belongs_to :doctor

  named_scope :on_date, lambda { |date| {:conditions => ["from_date = ?", date ] } }
end
