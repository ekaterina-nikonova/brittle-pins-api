# frozen_string_literal: true

module Mutations
  class UpdateSection < BaseMutation
    argument :projectId, ID, required: true
    argument :chapterId, ID, required: true
    argument :sectionId, ID, required: true
    argument :attributes, Types::SectionAttributesType, required: true

    field :section, Types::SectionType, null: true
    field :errors, [String], null: false

    def resolve(project_id: '', chapter_id: '', section_id: '', attributes:)
      user = context[:current_user]
      return { section: nil, errors: ['Not authorized'] } unless user

      project = user.projects.find(project_id)
      chapter = project.chapters.find(chapter_id)
      section = chapter.sections.find(section_id)

      if section.update(attributes.to_h)
        { section: section, errors: [] }
      else
        { section: nil, errors: section.errors.full_messages }
      end
    end
  end
end
