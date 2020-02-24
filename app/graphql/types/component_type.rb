module Types
  class ComponentType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :image_url, String, null: true

    def image_url
      return '' unless object.image.attached?

      Rails.application.routes.url_helpers.rails_blob_url(object.image)
    end
  end
end
