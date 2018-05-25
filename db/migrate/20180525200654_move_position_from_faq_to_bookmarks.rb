class MovePositionFromFaqToBookmarks < ActiveRecord::Migration
   def down
  	add_column :faqs, :position, :integer
  end
  def up
  	remove_column :faqs, :position
  end
end
