module Types
  class BoardType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :image_url, String, null: true
    field :description, String, null: true
    field :components, [ComponentType], null: true

    def image_url
      return '' unless object.image.attached?

      object.image.service_url
    end
  end
end
