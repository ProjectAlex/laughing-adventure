class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :type
      t.text :content
      t.text :caption
      t.references :user, index: true

      t.timestamps
    end
  end
end
