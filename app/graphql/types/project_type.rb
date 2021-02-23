module Types
  class ProjectType < BaseObject
    field :id, ID, null: false
    field :created_at, String, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :public, Boolean, null: false
    field :user, String, null: false

    field :board, BoardType, null: false
    field :components, [ComponentType], null: true

    field :chapters, [ChapterType], null: true

    field :chapter_count, Int, null: false
    field :component_count, Int, null: false

    def created_at
      object.created_at
    end

    def user
      object.user.username
    end

    def chapter_count
      object.chapters.count
    end

    def component_count
      object.components.count
    end
  end
end
