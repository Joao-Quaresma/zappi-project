class AddUserIdToSocialposts < ActiveRecord::Migration
  def change
    add_reference :socialposts, :user, index: true, foreign_key: true
  end
end
