class AddAttachmentGravatarToTopics < ActiveRecord::Migration
  def self.up
    change_table :topics do |t|
      t.attachment :gravatar
    end
  end

  def self.down
    drop_attached_file :topics, :gravatar
  end
end
