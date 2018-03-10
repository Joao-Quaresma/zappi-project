class CreateAnnouncementCategories < ActiveRecord::Migration
  def change
    create_table :announcement_categories do |t|
            t.integer :announcement_id
            t.integer :category_id
    end
  end
end
