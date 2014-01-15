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
  has_attached_file :avatar, :styles => { :medium => "100x100#", :thumb => "50x50#" }, :default_url => "default_avatar.png"
end
