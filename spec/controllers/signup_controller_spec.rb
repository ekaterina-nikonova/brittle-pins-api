# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SignupController, type: :controller do
  describe 'POST create' do
    let(:user) { build :user }
    let(:user_params) { { username: user.username,
                          email: user.email,
                          password: user.password,
                          password_confirmation: user.password } }

    it 'returns http success' do
      post :create, params: user_params
      expect(response).to be_successful
      expect(response_json.keys).to eq ['csrf']
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'creates a new user' do
      expect do
        post :create, params: user_params
      end.to change(User, :count).by(1)
    end
  end
end
