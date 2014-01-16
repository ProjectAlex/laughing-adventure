class Post < ActiveRecord::Base
    has_many :comments , dependent: :destroy
    belongs_to :user
    validates_presence_of :content,:caption
end
