class AddAttachmentToAnnouncement < ActiveRecord::Migration
  def change
    add_attachment :announcements, :attachment, :document
  end
end
