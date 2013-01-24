class Sulat < ActiveRecord::Base
  attr_accessible :msgbody, :read, :recipient_id, :sender_id, :subject

  #validation
  validates :recipient_id, presence: true
  validates :sender_id, presence: true

  #relationships
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"

end
