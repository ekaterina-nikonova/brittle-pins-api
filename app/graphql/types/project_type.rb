module Types
  class ProjectType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true

    field :board, BoardType, null: false
    field :components, [ComponentType], null: true

    field :chapters, [ChapterType], null: true

    field :chapter_count, Int, null: false
    field :component_count, Int, null: false

    def chapter_count
      object.chapters.count
    end

    def component_count
      object.components.count
    end
  end
end
