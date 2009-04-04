class Reason < SelectOption
  has_many :appointments
   validates_presence_of :name,:description
end
