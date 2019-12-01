module Types
  class SubscriptionType < BaseObject
    field :projectAdded, Types::ProjectType, null: true
    def project_added; end

    field :projectDeleted, ID, null: true
    def project_deleted; end

    field :projectUpdated, Types::ProjectType, null: true
    def project_updated; end
  end
end
