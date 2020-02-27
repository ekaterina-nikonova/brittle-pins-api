module Types
  class SectionType < BaseObject
    field :id, ID, null: false
    field :paragraph, String, null: false
    field :code, String, null: true
    field :language, String, null: true
    field :image_url, String, null: true

    def image_url
      return '' unless object.image.attached?

      object.image.service_url
    end
  end
end
