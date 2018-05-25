class MovePositionFromAnnouncementToBookmarks < ActiveRecord::Migration
   def down
  	add_column :announcements, :position, :integer
  end
  def up
  	remove_column :announcements, :position
  end
end
