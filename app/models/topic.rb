class Topic < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: :slugged
    has_attached_file :gravatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "default_avatar.png"
    acts_as_followable
end
