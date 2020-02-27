# frozen_string_literal: true

module Mutations
  class CreateBoard < BaseMutation
    null true

    argument :name, String, required: true
    argument :description, String, required: false

    field :board, Types::BoardType, null: true
    field :errors, [String], null: false

    def resolve(name: '', description: '')
      user = context[:current_user]
      return { board: nil, errors: ['Not authorized'] } unless user

      board = user.boards.build(name: name, description: description)

      if board.save
        { board: board, errors: [] }
      else
        { board: nil, errors: board.errors.full_messages }
      end
    end
  end
end
