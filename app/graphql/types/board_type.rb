module Types
  class BoardType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :image_url, String, null: true
    field :description, String, null: true
    field :components, [ComponentType], null: true

    def image_url
      return '' unless object.image.attached?

      Rails.application.routes.url_helpers
          .rails_blob_url(object.image)
    end
  end
end
