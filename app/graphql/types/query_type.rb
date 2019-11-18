module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :boards, [BoardType], null: true
    def boards
      context[:current_user].boards.order(:created_at)
    end

    field :components, [ComponentType], null: true
    def components
      context[:current_user].components.order(:created_at)
    end

    field :componentsForBoard, [ComponentType], null: true do
      argument :boardId, ID, required: true
    end
    def components_for_board(board_id:)
      context[:current_user].boards.find(board_id).components.order(:created_at)
    end

    field :projects, [ProjectType], null: true
    def projects
      context[:current_user].projects.order(:created_at)
    end
  end
end
