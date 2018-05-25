class MovePositionFromArticleToBookmarks < ActiveRecord::Migration
  def down
  	remove_column :bookmarks, :position
  	add_column :articles, :position, :integer
  end
  def up
  	remove_column :articles, :position
  	add_column :bookmarks, :position, :integer
  end
end

