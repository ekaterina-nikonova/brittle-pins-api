# frozen_string_literal: true

module Mutations
  class DeleteComponent < BaseMutation
    null true

    argument :id, ID, required: true

    field :component, Types::ComponentType, null: true
    field :errors, [String], null: false

    def resolve(id: '')
      user = context[:current_user]
      return { component: nil, errors: ['Not authorized'] } unless user

      component = user.components.find(id)

      if component.destroy
        { component: component, errors: [] }
      else
        { component: nil, errors: component.errors.full_messages }
      end
    end
  end
end
