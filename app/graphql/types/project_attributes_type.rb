# frozen_string_literal: true

module Types
  class ProjectAttributesType < BaseInputObject
    argument :name, String, required: false
    argument :description, String, required: false
    argument :public, Boolean, required: false
    argument :board, ID, required: false
    argument :components, [String], required: false
  end
end
