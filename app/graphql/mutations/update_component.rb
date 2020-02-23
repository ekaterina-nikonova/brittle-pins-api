# frozen_string_literal: true

module Mutations
  class UpdateComponent < BaseMutation
    null true

    argument :id, ID, required: true
    argument :attributes, Types::ComponentAttributesType, required: true

    field :component, Types::ComponentType, null: true
    field :errors, [String], null: false

    def resolve(id: '', attributes:)
      user = context[:current_user]
      return { component: nil, errors: ['Not authorized'] } unless user

      component = user.components.find(id)

      attrs = attributes.to_h

      if component.update(attrs)
        { component: component, errors: [] }
      else
        { component: nil, errors: component.errors.full_messages }
      end
    end
  end
end
