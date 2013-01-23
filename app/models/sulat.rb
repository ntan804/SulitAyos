class Sulat < ActiveRecord::Base
  attr_accessible :msgbody, :read, :receiver_id, :sender_id, :subject

  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :receiver, :class_name => "User", :foreign_key => "receiver_id"

end
