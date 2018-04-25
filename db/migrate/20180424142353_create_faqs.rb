class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :title
      t.text :description
      t.text :body
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
