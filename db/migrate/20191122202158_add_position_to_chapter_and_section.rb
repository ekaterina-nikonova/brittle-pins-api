class AddPositionToChapterAndSection < ActiveRecord::Migration[6.0]
  def change
    add_column :chapters, :position, :integer
    add_column :sections, :position, :integer
  end
end
