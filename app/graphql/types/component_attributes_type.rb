# frozen_string_literal: true

module Types
  class ComponentAttributesType < BaseInputObject
    argument :name, String, required: false
    argument :description, String, required: false
    argument :boards, [String], required: false
  end
end
