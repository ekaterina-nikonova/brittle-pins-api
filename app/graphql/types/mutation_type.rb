module Types
  class MutationType < Types::BaseObject
    field :create_project, mutation: Mutations::CreateProject
    field :delete_project, mutation: Mutations::DeleteProject
    field :update_project, mutation: Mutations::UpdateProject

    field :create_chapter, mutation: Mutations::CreateChapter
    field :create_section, mutation: Mutations::CreateSection
  end
end
