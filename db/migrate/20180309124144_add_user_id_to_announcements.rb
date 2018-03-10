class AddUserIdToAnnouncements < ActiveRecord::Migration
  def change
    add_reference :announcements, :user, index: true, foreign_key: true
  end
end
