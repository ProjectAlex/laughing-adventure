class AddUpsAndDownsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :ups, :integer
    add_column :posts, :downs, :integer
  end
end
