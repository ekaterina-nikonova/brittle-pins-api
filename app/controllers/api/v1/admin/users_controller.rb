# frozen_string_literal: true

# Admin space - managing users, app settings, etc.

module Api::V1::Admin
  # Manage users - admin and manager roles
  # (https://medium.com/@yuliaoletskaya/rails-api-jwt-auth-vuejs-spa-part-2-roles-601e4372a7e7)
  class UsersController < ApplicationController
    before_action :authorize_access_request!
    ROLES = %w[admin manager].freeze

    def index
      @users = User.all
      render json: @users.as_json(only: %i[id username email role])
    end

    def token_claims
      { aud: ROLES, verify_aud: true }
    end
  end
end
