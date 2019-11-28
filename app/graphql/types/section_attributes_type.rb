# frozen_string_literal: true

module Types
  class SectionAttributesType < BaseInputObject
    argument :paragraph, String, required: false
    argument :code, String, required: false
  end
end
