class AddBoardReferenceToProjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :board, type: :uuid, foreign_key: true
  end
end
