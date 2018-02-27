class CreateSocialposts < ActiveRecord::Migration
  def change
    create_table :socialposts do |t|
      t.string :caption

      t.timestamps null: false
    end
  end
end
