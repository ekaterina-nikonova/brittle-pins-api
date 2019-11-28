# frozen_string_literal: true

module Mutations
  class DeleteSection < BaseMutation
    argument :project_id, ID, required: true
    argument :chapter_id, ID, required: true
    argument :section_id, ID, required: true

    field :section, Types::SectionType, null: true
    field :errors, [String], null: false

    def resolve(project_id: '', chapter_id: '', section_id: '')
      user = context[:current_user]
      return { section: nil, errors: ['Not authorized'] } unless user

      project = user.projects.find(project_id)
      chapter = project.chapters.find(chapter_id)
      section = chapter.sections.find(section_id)

      if section.destroy
        { section: section, errors: [] }
      else
        { section: nil, errors: section.errors.full_messages }
      end
    end
  end
end
