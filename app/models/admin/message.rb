class Admin::Message < ActiveRecord::Base
belongs_to :contact_group
belongs_to :contact_list
belongs_to :user
has_many :message_contact_lists
has_many :contact_lists,:through => :message_contact_lists
end
