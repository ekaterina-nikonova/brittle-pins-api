# frozen_string_literal: true

module Mutations
  class DeleteBoard < BaseMutation
    null true

    argument :id, ID, required: true

    field :board, Types::BoardType, null: true
    field :errors, [String], null: false

    def resolve(id: '')
      user = context[:current_user]
      return { board: nil, errors: ['Not authorized'] } unless user

      board = user.boards.find(id)

      if board.destroy
        { board: board, errors: [] }
      else
        { board: nil, errors: board.errors.full_messages }
      end
    end
  end
end
