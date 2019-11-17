module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :boards, [BoardType], null: true
    def boards
      context[:current_user].boards
    end

    field :projects, [ProjectType], null: true
    def projects
      context[:current_user].projects
    end
  end
end
