class CreateAnnouncementnotifications < ActiveRecord::Migration
  def change
    create_table :announcementnotifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :notified_by, index: true, foreign_key: true
      t.references :announcement, index: true, foreign_key: true
      t.integer :identifier
      t.string :notice_type
      t.boolean :read, default: false

      t.timestamps null: false
    end
    add_foreign_key :announcementnotifications, :users
    add_foreign_key :announcementnotifications, :users, column: :notified_by_id
    add_foreign_key :announcementnotifications, :announcements
  end
end
