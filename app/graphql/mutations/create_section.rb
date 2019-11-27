# frozen_string_literal: true

module Mutations
  class CreateSection < BaseMutation
    argument :projectId, ID, required: true
    argument :chapterId, ID, required: true
    argument :paragraph, String, required: true
    argument :code, String, required: false

    field :section, Types::SectionType, null: true
    field :errors, [String], null: false

    def resolve(project_id: '', chapter_id: '', paragraph: '', code: '')
      user = context[:current_user]
      return { section: nil, errors: ['Not authorized'] } unless user

      project = user.projects.find(project_id)
      chapter = project.chapters.find(chapter_id)
      section = chapter.sections.build(paragraph: paragraph, code: code)

      if section.save
        { section: section, errors: [] }
      else
        { section: nil, errors: section.errors.full_messages }
      end
    end
  end
end
