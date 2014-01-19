class LikersDislikersList < ActiveRecord::Migration
  def change

    create_table(:likers, :id => false) do |t|
      t.references :user
      t.references :post
    end
    
     create_table(:dislikers, :id => false) do |t|
      t.references :user
      t.references :post
    end

    add_index(:likers, [ :user_id, :post_id ])
    add_index(:dislikers, [ :user_id, :post_id ])
  end
end
