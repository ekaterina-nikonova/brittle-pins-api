# frozen_string_literal: true

module Mutations
  class DeleteChapter < BaseMutation
    argument :chapter_id, ID, required: true
    argument :project_id, ID, required: true

    field :chapter, Types::ChapterType, null: true
    field :project, Types::ProjectType, null: false
    field :errors, [String], null: false

    def resolve(chapter_id: '', project_id: '')
      user = context[:current_user]
      return { chapter: nil, errors: ['Not authorized'] } unless user

      project = user.projects.find(project_id)
      chapter = project.chapters.find(chapter_id)

      if chapter.destroy
        { chapter: chapter, project: project, errors: [] }
      else
        { chapter: nil, project: project, errors: chapter.errors.full_messages }
      end
    end
  end
end
