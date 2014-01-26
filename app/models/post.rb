class Post < ActiveRecord::Base
    has_many :comments , dependent: :destroy
    belongs_to :user
    has_attached_file :att_file
    validates_presence_of :content,:caption
   has_and_belongs_to_many :likers,
 :class_name => 'User',
 :join_table => :likers
   has_and_belongs_to_many :dislikers,
 :class_name => 'User',
 :join_table => :dislikers
   acts_as_taggable
end
