# frozen_string_literal: true

module Mutations
  class CreateProject < BaseMutation
    null true

    argument :board_id, ID, required: true
    argument :name, String, required: true

    field :project, Types::ProjectType, null: true
    field :errors, [String], null: false

    def resolve(name: '', board_id:)
      pp '---user---'
      pp context[:current_user]

      user = context[:current_user]

      # return { project: nil, errors: ['Not authorized'] } unless user

      project = user.projects.build(name: name,
                                    board: user.boards.find(board_id))

      if project.save
        { project: project, errors: [] }
      else
        { project: nil, errors: project.errors.full_messages }
      end
    end
  end
end
