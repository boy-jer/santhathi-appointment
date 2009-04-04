class Mode  < SelectOption
   validates_presence_of :name
   has_many :appointments
end
