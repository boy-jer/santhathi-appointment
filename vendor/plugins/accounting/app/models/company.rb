class Company < ActiveRecord::Base      
  has_many :branches
  has_many :users

  attr_accessible :name
  validates_presence_of :name
  validates_uniqueness_of :name

  after_create :set_up_branch
  
  def main_branch
    branches.find_by_name('Main')
  end

  protected

  def set_up_branch
    branch = branches.build
    branch.name = 'Main'
    branch.save!
  end
end
