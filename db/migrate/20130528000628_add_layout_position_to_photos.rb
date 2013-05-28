class AddLayoutPositionToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :layout_position, :integer
  end
end
