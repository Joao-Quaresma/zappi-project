class CreateArticlenotifications < ActiveRecord::Migration
  def change
    create_table :articlenotifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :notified_by, index: true, foreign_key: true
      t.references :article, index: true, foreign_key: true
      t.integer :identifier
      t.string :notice_type
      t.boolean :read, default: false

      t.timestamps null: false
    end
    add_foreign_key :articlenotifications, :users
    add_foreign_key :articlenotifications, :users, column: :notified_by_id
    add_foreign_key :articlenotifications, :articles
  end
end
