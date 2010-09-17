class User < ActiveRecord::Base
  acts_as_authentic
  
  belongs_to :company
  belongs_to :branch

  validates_presence_of :company, :name
  attr_accessible :login, :password, :password_confirmation, :email, :company_attributes, :name
  accepts_nested_attributes_for :company    

  after_create :set_up_default_branch

  protected

  def set_up_default_branch
    update_attribute(:branch_id, company.main_branch.id)
  end
end
