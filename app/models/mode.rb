class Mode  < SelectOption
   validates_presence_of :name
   has_many :appointments

   def self.modes_list
    self.find(:all).collect{|mode| [mode.name, mode.id] }
  end

end
