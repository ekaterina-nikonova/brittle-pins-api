module Types
  class ChapterType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :intro, String, null: true
    field :sections, [SectionType], null: true
  end
end
