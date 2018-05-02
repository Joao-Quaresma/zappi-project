class AddPositionToFaq < ActiveRecord::Migration
  def change
    add_column :faqs, :position, :integer
  end
end
