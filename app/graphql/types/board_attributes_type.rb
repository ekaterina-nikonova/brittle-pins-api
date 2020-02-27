# frozen_string_literal: true

module Types
  class BoardAttributesType < BaseInputObject
    argument :name, String, required: false
    argument :description, String, required: false
    argument :components, [String], required: false
  end
end
