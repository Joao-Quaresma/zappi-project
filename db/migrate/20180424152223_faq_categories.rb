class FaqCategories < ActiveRecord::Migration
  def change
  	create_table :faq_categories do |t|
      t.integer :faq_id
      t.integer :category_id
    end
  end
end
