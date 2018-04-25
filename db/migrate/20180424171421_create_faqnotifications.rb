class CreateFaqnotifications < ActiveRecord::Migration
   def change
    create_table :faqnotifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :notified_by, index: true, foreign_key: true
      t.references :faq, index: true, foreign_key: true
      t.integer :identifier
      t.string :notice_type
      t.boolean :read, default: false

      t.timestamps null: false
    end
    add_foreign_key :faqnotifications, :users
    add_foreign_key :faqnotifications, :users, column: :notified_by_id
    add_foreign_key :faqnotifications, :faq
  end
end
