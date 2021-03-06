module Types
  class SubscriptionType < BaseObject
    field :projectAdded, Types::ProjectType, null: true
    def project_added; end

    field :projectDeleted, ID, null: true
    def project_deleted; end

    field :projectUpdated, Types::ProjectType, null: true
    def project_updated; end

    field :boardAdded, Types::BoardType, null: true
    def board_added; end

    field :boardDeleted, ID, null: true
    def board_deleted; end

    field :boardUpdated, Types::BoardType, null: true
    def board_updated; end

    field :componentAdded, Types::ComponentType, null: true
    def component_added; end

    field :componentDeleted, ID, null: true
    def component_deleted; end

    field :componentUpdated, Types::ComponentType, null: true
    def component_updated; end
  end
end
