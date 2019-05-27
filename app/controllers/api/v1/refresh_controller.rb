# frozen_string_literal: true

module Api::V1
  class RefreshController < ApplicationController
    pp '---***--- r1 ---***---'
    before_action :authorize_refresh_by_access_request!

    def create
      pp '---***--- r2 ---***---'
      session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)

      tokens = session.refresh_by_access_payload do
        # TODO: notify support, flush the session, or skip the block
        # See https://blog.usejournal.com/rails-api-jwt-auth-vuejs-spa-eb4cf740a3ae
        raise JWTSessions::Errors::Unauthorized, 'Malicious activity detected'
      end

      pp '---***--- r3 ---***---'
      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)

      pp '---***--- r4 ---***---'
      render json: { csrf: tokens[:csrf] }
    end
  end
end
