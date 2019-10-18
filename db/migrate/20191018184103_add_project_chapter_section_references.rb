class AddProjectChapterSectionReferences < ActiveRecord::Migration[6.0]
  def change
    add_reference :sections, :chapter, type: :uuid, foreign_key: true
    add_reference :chapters, :project, type: :uuid, foreign_key: true
  end
end
