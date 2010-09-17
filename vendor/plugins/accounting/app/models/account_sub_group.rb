class AccountSubGroup < AccountGroup
  belongs_to :account_main_group, :foreign_key => 'parent_id'
  belongs_to :branch 
  validates_presence_of :parent_id, :branch_id, :account_group_type_id
end
