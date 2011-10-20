class LaboratoryTestGroup < ActiveRecord::Base
    has_many :services


  def self.option_for_select
    all_group = [["Select Group",""]]
    all_group += self.find(:all).collect{|model| [model.name, model.id]}
  end
end

