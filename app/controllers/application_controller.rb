# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    pp '---***--- 1-1 ---***---'
    @current_user ||= User.find(payload['user_id'])
  end

  def not_authorized
    pp '---***--- 1-2 ---***---'
    render json: { error: 'Not authorized' }, status: :unauthorized
  end
end
