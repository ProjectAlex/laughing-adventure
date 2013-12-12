class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :nature
      t.text :content
      t.text :caption
      t.string :posted_by
      t.integer :posted_by_uid

      t.timestamps
    end
  end
end
