# frozen_string_literal: true

module Mutations
  class UpdateChapter < BaseMutation
    argument :projectId, ID, required: true
    argument :chapterId, ID, required: true
    argument :attributes, Types::ChapterAttributesType, required: true

    field :chapter, Types::ChapterType, null: true
    field :errors, [String], null: false

    def resolve(project_id: '', chapter_id: '', attributes:)
      user = context[:current_user]
      return { chapter: nil, errors: ['Not authorized'] } unless user

      project = user.projects.find(project_id)
      chapter = project.chapters.find(chapter_id)

      if chapter.update(attributes.to_h)
        { chapter: chapter, errors: [] }
      else
        { chapter: nil, errors: chapter.errors.full_messages }
      end
    end
  end
end
