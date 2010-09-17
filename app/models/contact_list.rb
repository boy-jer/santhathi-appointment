class ContactList < ActiveRecord::Base
belongs_to :contact_group
has_many :message_contact_lists
has_many :messages,:through => :message_contact_lists
end
