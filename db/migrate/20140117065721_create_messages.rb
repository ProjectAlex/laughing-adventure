class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
	t.string :sender_id,:null => false
	t.string :recepient_id
	t.boolean :sender_deleted, :recepient_deleted, :default => 0
	t.string :subject,:null => false
	t.string :slug
	t.text :body
	t.datetime :read_at
	t.datetime :sent_at
	t.string :container,:default => "normal"

      t.timestamps
    end
    add_index :messages, :slug, unique: true
  end
end
