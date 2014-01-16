class AddAttachmentAttFileToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :att_file
    end
  end

  def self.down
    drop_attached_file :posts, :att_file
  end
end
