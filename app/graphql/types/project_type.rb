module Types
  class ProjectType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true

    field :board, BoardType, null: false
    field :components, [ComponentType], null: true

    field :chapters, [ChapterType], null: true
  end
end
