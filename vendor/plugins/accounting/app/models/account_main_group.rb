class AccountMainGroup < AccountGroup
  has_many :account_sub_groups, :foreign_key => 'parent_id'
  belongs_to :branch
  validates_presence_of :account_group_type_id, :branch_id  
end
