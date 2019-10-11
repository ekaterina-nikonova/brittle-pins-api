# frozen_string_literal: true

# Admin space - manage users and app settings
module Api::V1::Admin
  # Manage invitations for sign-ups
  class InvitationsController < ApplicationController
    before_action :authorize_access_request!, only: [:destroy]
    before_action :set_invitation, only: [:destroy]
    ROLES = %w[admin manager].freeze

    def create
      @invitation = Invitation.new(
        email: invitation_params[:email]
      )
      @invitation.save
      head :created
    end

    def destroy
      if @invitation.destroy
        head :no_content
      else
        render json: @invitation.errors, status: :unprocessable_entity
      end
    end

    def token_claims
      { aud: ROLES, verify_aud: true }
    end

    private

    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    def invitation_params
      params.permit(:email)
    end
  end
end
