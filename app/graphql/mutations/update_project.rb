# frozen_string_literal: true

module Mutations
  class UpdateProject < BaseMutation
    null true

    argument :id, ID, required: true
    argument :attributes, Types::ProjectAttributesType, required: true

    field :project, Types::ProjectType, null: true
    field :errors, [String], null: false

    def resolve(id: '', attributes:)
      user = context[:current_user]
      return { project: nil, errors: ['Not authorized'] } unless user

      project = user.projects.find(id)

      attrs = attributes.to_h
      attrs[:board] = user.boards.find(attributes[:board]) if attributes[:board]

      if attributes[:components]
        attrs[:components] = attributes[:components].map do |c|
          user.components.find(c)
        end
      end

      if project.update(attrs)
        { project: project, errors: [] }
      else
        { project: nil, errors: project.errors.full_messages }
      end
    end
  end
end
