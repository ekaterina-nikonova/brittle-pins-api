# frozen_string_literal: true

module Mutations
  class CreateProject < BaseMutation
    null true

    argument :boardId, ID, required: true
    argument :name, String, required: true
    argument :description, String, required: false
    argument :components, [String], required: false

    field :project, Types::ProjectType, null: true
    field :errors, [String], null: false

    def resolve(name: '', board_id: '', description: '', components: [])
      user = context[:current_user]
      return { project: nil, errors: ['Not authorized'] } unless user

      project = user.projects.build(name: name,
                                    board: user.boards.find(board_id),
                                    description: description,
                                    components: find_for(user, components))
      if project.save
        { project: project, errors: [] }
      else
        { project: nil, errors: project.errors.full_messages }
      end
    end

    private

    def find_for(user, components)
      components.map { |id| user.components.find(id) }
    end
  end
end
