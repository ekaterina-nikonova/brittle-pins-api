# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    object_class Types::BaseObject
    field_class Types::BaseField
  end
end
