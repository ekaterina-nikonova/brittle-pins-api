module Types
  class MutationType < Types::BaseObject
    field :create_project, mutation: Mutations::CreateProject
    field :delete_project, mutation: Mutations::DeleteProject
    field :update_project, mutation: Mutations::UpdateProject

    field :create_chapter, mutation: Mutations::CreateChapter
    field :delete_chapter, mutation: Mutations::DeleteChapter
    field :update_chapter, mutation: Mutations::UpdateChapter

    field :create_section, mutation: Mutations::CreateSection
    field :delete_section, mutation: Mutations::DeleteSection
  end
end
