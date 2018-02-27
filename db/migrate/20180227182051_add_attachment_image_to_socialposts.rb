class AddAttachmentImageToSocialposts < ActiveRecord::Migration
  def self.up
    change_table :socialposts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :socialposts, :image
  end
end
