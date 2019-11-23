module Types
  class SectionType < BaseObject
    field :id, ID, null: false
    field :paragraph, String, null: false
    field :code, String, null: true
    field :image_url, String, null: true

    def image_url
      return '' unless object.image.attached?

      Rails.application.routes.url_helpers
           .rails_blob_url(object.image)
    end
  end
end
