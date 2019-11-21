module Types
  class SubscriptionType < BaseObject
    field :projectAdded, Types::ProjectType, null: false
    def project_added; end

    field :projectDeleted, Types::ProjectType, null: true
    def project_deleted; end
  end
end
