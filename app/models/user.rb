class User < ActiveRecord::Base 
    rolify
    extend FriendlyId
    friendly_id :name, use: :slugged

    after_create :assign_default_role

    def assign_default_role
        if User.count == 1    
            add_role(:admin)
        else 
            add_role(:user)
        end
    end

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :confirmable,
        :recoverable, :rememberable, :trackable, :validatable
    has_many :posts

    has_attached_file :avatar, :styles => { :large => "500x500" , :medium => "300x300>", :thumb => "10x10>" }, :default_url => "default_avatar.png"
    validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png']   
    scope :confirmed, where("confirmed_at IS NOT NULL")
    
    has_many :received_messages,
 :class_name => 'Message',
 :primary_key=>'id',
 :foreign_key => 'recepient_id',
 :order => "messages.created_at DESC",
 :conditions => ["messages.recepient_deleted = ?", false]
    
    has_many :sent_messages,
 :class_name => 'Message',
 :primary_key=>'id',
 :foreign_key => 'recepient_id',
 :order => "messages.created_at DESC",
 :conditions => ["messages.recepient_deleted = ?", false]
 
 def received_messages
  Message.where(:recepient_id => self.id).order('sent_at DESC').load
 end
 
 def sent_messages
  Message.where(:sender_id => self.id).order('sent_at DESC').load
 end
    
 def unread_messages?
  unread_message_count > 0 ? true : false
 end
 
# Returns the number of unread messages for this user
 def unread_message_count
  eval 'received_messages.count(:conditions => ["read_at IS NULL"])'
 end
 searchable do
    text :name
    text :email
 end
end
