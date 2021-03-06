# frozen_string_literal: true

module Api::V1
  class RefreshController < ApplicationController
    before_action :authorize_refresh_by_access_request!

    def create
      session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)

      tokens = session.refresh_by_access_payload do
        # TODO: notify support, flush the session, or skip the block
        # See https://blog.usejournal.com/rails-api-jwt-auth-vuejs-spa-eb4cf740a3ae
        raise JWTSessions::Errors::Unauthorized, 'Malicious activity detected'
      end

      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)

      render json: { csrf: tokens[:csrf] }
    end
  end
end
