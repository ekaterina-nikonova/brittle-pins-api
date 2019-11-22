module Types
  class SectionType < BaseObject
    field :id, ID, null: false
    field :paragraph, String, null: false
    field :code, String, null: true
    field :image, String, null: true
  end
end
