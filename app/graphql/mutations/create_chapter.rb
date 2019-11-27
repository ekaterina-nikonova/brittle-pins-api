# frozen_string_literal: true

module Mutations
  class CreateChapter < BaseMutation
    argument :projectId, ID, required: true
    argument :name, String, required: true
    argument :intro, String, required: false

    field :chapter, Types::ChapterType, null: true
    field :project, Types::ProjectType, null: true
    field :errors, [String], null: false

    def resolve(project_id:, name:, intro: '')
      user = context[:current_user]
      return { chapter: nil, errors: ['Not authorized'] } unless user

      project = user.projects.find(project_id)

      chapter = project.chapters.build(name: name, intro: intro)

      if chapter.save
        { chapter: chapter, errors: [] }
      else
        { chapter: nil, errors: chapter.errors.full_messages }
      end
    end
  end
end
