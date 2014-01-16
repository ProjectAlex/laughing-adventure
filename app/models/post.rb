class Post < ActiveRecord::Base
    has_many :comments , dependent: :destroy
    belongs_to :user
    validates_presence_of :nature,:content,:caption
end
