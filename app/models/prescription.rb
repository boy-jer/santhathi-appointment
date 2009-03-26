class Prescription < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :department
  has_and_belongs_to_many :services
end
