# frozen_string_literal: true

module Mutations
  class UpdateBoard < BaseMutation
    null true

    argument :id, ID, required: true
    argument :attributes, Types::BoardAttributesType, required: true

    field :board, Types::BoardType, null: true
    field :errors, [String], null: false

    def resolve(id: '', attributes:)
      user = context[:current_user]
      return { board: nil, errors: ['Not authorized'] } unless user

      board = user.boards.find(id)

      attrs = attributes.to_h

      if attributes[:components]
        attrs[:components] = attributes[:components].map do |c|
          user.components.find(c)
        end
      end

      if board.update(attrs)
        { board: board, errors: [] }
      else
        { board: nil, errors: board.errors.full_messages }
      end
    end
  end
end
