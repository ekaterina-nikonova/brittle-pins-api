# frozen_string_literal: true

module Types
  class ChapterAttributesType < BaseInputObject
    argument :name, String, required: false
    argument :intro, String, required: false
  end
end
