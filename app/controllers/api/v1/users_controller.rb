# frozen_string_literal: true

# Generated for creating 'me' endpoint
# (see https://medium.com/@yuliaoletskaya/rails-api-jwt-auth-vuejs-spa-part-2-roles-601e4372a7e7)

class Api::V1::UsersController < ApplicationController
  before_action :authorize_access_request!
  def me
    render json: current_user.as_json(only: [:id, :email, :username, :role])
  end
end
