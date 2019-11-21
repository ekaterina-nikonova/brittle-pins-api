module Types
  class MutationType < Types::BaseObject
    field :create_project, mutation: Mutations::CreateProject
    field :delete_project, mutation: Mutations::DeleteProject
  end
end
