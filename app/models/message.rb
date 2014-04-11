class Message < ActiveRecord::Base
  extend FriendlyId
    friendly_id :subject, use: :slugged
 validates_presence_of :subject, :message => "Please enter message title"
 private
  def app_params
    params.require(:list).permit(:subject, :body, :sender_id, :recepient_id, :read_at,:sender_deleted,:recepient_deleted)
  end
  public
  belongs_to :sender,
 :primary_key => 'id',
 :foreign_key => 'sender_id'
  belongs_to :recepient,
 :primary_key => 'id',
 :foreign_key => 'recepient_id'

 
# marks a message as deleted by either the sender or the recepient, which ever the user that was passed is.
 # When both sender and recepient marks it deleted, it is destroyed.
 def mark_message_deleted(id,user_id)
 self.sender_deleted = true if self.sender_id == user_id and self.id=id
 self.recepient_deleted = true if self.recepient_id == user_id and self.id=id
 self.sender_deleted && self.recepient_deleted ? self.destroy : save!
 end
 
# Read message and if it is read by recepient then mark it is read
 def self.readingmessage(id, reader)
 message = friendly.find(id, :conditions => ["sender_id = ? OR recepient_id = ?", reader, reader])
 #if message.read_at.nil? && (message.recepient.id==reader)
 message.read_at = Time.now
 message.save!
 #end
 message
 end
 
# Based on if a message has been read by it's recepient returns true or false.
 def read?
 self.read_at.nil? ? false : true
 end
 
 def trashed?
 false
 end
 
 def received?
 true
 end


end
