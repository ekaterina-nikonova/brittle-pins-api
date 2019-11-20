module Types
  class SubscriptionType < BaseObject
    field :projectAdded, Types::ProjectType, null: false
    def project_added; end
  end
end
