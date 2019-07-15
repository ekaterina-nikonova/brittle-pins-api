# frozen_string_literal: true

# Admin space - Managing users
module Api::V1::Admin::Users
  # Manage users' boards - admin only
  class BoardsController < ApplicationController
    before_action :authorize_access_request!
    before_action :set_user
    ROLES = %w[admin].freeze

    def index
      render json: @user.boards
    end

    def token_claims
      { aud: ROLES, verify_aud: true }
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
