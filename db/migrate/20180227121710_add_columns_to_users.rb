class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_role, :string
    add_column :users, :nickname, :string
    add_column :users, :resume, :text
  end
end
