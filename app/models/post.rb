class Post < ActiveRecord::Base
    has_many :comments , dependent: :destroy
    belongs_to :user
    has_attached_file :att_file, :styles => { :large => "500x500" , :medium => "300x300>" }
    validates_attachment_content_type :att_file, :content_type => ['image/jpeg', 'image/jpg', 'image/png', "application/pdf","application/msword"]
    validates_presence_of :content,:caption
   has_and_belongs_to_many :likers,
 :class_name => 'User',
 :join_table => :likers
   has_and_belongs_to_many :dislikers,
 :class_name => 'User',
 :join_table => :dislikers
   acts_as_taggable
end
