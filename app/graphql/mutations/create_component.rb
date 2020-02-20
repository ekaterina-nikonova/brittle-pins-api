# frozen_string_literal: true

module Mutations
  class CreateComponent < BaseMutation
    null true

    argument :name, String, required: true
    argument :description, String, required: false

    field :component, Types::ComponentType, null: true
    field :errors, [String], null: false

    def resolve(board_id: '', name: '', description: '')
      user = context[:current_user]
      return { component: nil, errors: ['Not authorized'] } unless user

      component = user.components.build(name: name,
                                        description: description,
                                        board: user.boards.find(board_id))

      if component.save
        { component: component, errors: [] }
      else
        { component: nil, errors: component.errors.full_messages }
      end
    end
  end
end
