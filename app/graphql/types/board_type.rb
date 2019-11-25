module Types
  class BoardType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :components, [ComponentType], null: true
  end
end
