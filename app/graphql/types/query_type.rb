module Types
  class QueryType < Types::BaseObject
    field :projects, [ProjectType], null: true
    def projects
      context[:current_user].projects.order(:created_at).reverse_order
    end

    field :project, ProjectType, null: true do
      argument :id, ID, required: true
    end
    def project(id:)
      context[:current_user].projects.find(id)
    end

    field :boards, [BoardType], null: true
    def boards
      context[:current_user].boards.order(:created_at).reverse_order
    end

    field :components, [ComponentType], null: true
    def components
      context[:current_user].components.order(:created_at).reverse_order
    end

    field :componentsForBoard, [ComponentType], null: true do
      argument :boardId, ID, required: true
    end
    def components_for_board(board_id:)
      context[:current_user]
        .boards
        .find(board_id)
        .components
        .order(:created_at)
        .reverse_order
    end
  end
end
