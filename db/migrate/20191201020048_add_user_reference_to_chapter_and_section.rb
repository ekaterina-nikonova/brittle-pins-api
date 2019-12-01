# frozen_string_literal: true

# Select all chapters and all sections belonging to user;
# verify user before uploading section image
class AddUserReferenceToChapterAndSection < ActiveRecord::Migration[6.0]
  def change
    add_reference :chapters, :user, type: :uuid, foreign_key: true
    add_reference :sections, :user, type: :uuid, foreign_key: true
  end
end
