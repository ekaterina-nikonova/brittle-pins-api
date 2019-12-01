# frozen_string_literal: true

module Types
  class SectionAttributesType < BaseInputObject
    argument :paragraph, String, required: false
    argument :code, String, required: false
    argument :language, String, required: false
  end
end
