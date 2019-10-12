# frozen_string_literal: true

# Admin space - manage users and app settings
module Api::V1::Admin
  # Manage invitations for sign-ups
  class InvitationsController < ApplicationController
    before_action :authorize_access_request!, only: %i[index destroy]
    before_action :set_invitation, only: %i[destroy destroy_with_rejection]
    ROLES = %w[admin manager].freeze

    def index
      @invitations = Invitation.all.order(:created_at)
      render json: @invitations.as_json(only: %i[id code email])
    end

    def create
      return head :unprocessable_entity if taken?(invitation_params[:email])

      @invitation = Invitation.new(
        email: invitation_params[:email]
      )

      if @invitation.save
        head :created
      else
        head :unprocessable_entity
      end
    end

    def destroy
      if @invitation.destroy
        head :no_content
      else
        render json: @invitation.errors, status: :unprocessable_entity
      end
    end

    def destroy_with_rejection
      send_rejection_email
      destroy
    end

    def token_claims
      { aud: ROLES, verify_aud: true }
    end

    private

    def taken?(email)
      User.where(email: email).exists?
    end

    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    def send_rejection_email
      UserMailer.with(email: @invitation.email).rejection_email.deliver_later
    end

    def invitation_params
      params.permit(:email)
    end
  end
end
