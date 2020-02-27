# frozen_string_literal: true

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
    field :update_section, mutation: Mutations::UpdateSection

    field :create_board, mutation: Mutations::CreateBoard
    field :delete_board, mutation: Mutations::DeleteBoard
    field :update_board, mutation: Mutations::UpdateBoard

    field :create_component, mutation: Mutations::CreateComponent
    field :delete_component, mutation: Mutations::DeleteComponent
    field :update_component, mutation: Mutations::UpdateComponent
  end
end
