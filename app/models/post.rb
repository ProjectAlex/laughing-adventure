class Post < ActiveRecord::Base
    has_many :comments , dependent: :destroy
    belongs_to :user
    has_attached_file :att_file
    validates_presence_of :content,:caption
end
