# frozen_string_literal: true

module Types
  class ProjectAttributesType < BaseInputObject
    argument :board, ID, required: false
    argument :name, String, required: false
    argument :description, String, required: false
    argument :components, [String], required: false
  end
end
