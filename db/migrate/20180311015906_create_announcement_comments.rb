class CreateAnnouncementComments < ActiveRecord::Migration
  def change
    create_table :announcement_comments do |t|
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.references :announcement, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
