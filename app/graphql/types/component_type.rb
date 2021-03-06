module Types
  class ComponentType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :image_url, String, null: true

    field :projects, [ProjectType], null: true
    field :boards, [BoardType], null: true

    def image_url
      return '' unless object.image.attached?

      object.image.service_url
    end
  end
end
