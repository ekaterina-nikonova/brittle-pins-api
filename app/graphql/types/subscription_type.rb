module Types
  class SubscriptionType < BaseObject
    field :projectAdded, Types::ProjectType, null: false
    def project_added; end

    field :projectDeleted, ID, null: true
    def project_deleted; end
  end
end
