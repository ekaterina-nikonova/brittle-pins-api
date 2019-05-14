# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SigninController, type: :controller do
  describe 'POST create' do
    let(:user) { create :user }

    let(:user_params) { { email: user.email,
                          password: user.password } }

    let(:incorrect_password) { { email: user.email,
                                 password: 'incorrect' } }

    let(:incorrect_email) {{ email: 'em@a.il', password: 'abc' }}

    it 'returns http success' do
      post :create, params: user_params
      expect(response).to be_successful
      expect(response_json.keys).to eq ['csrf']
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'returns unauthorized when password incorrect' do
      post :create, params: incorrect_password
      expect(response).to have_http_status(401)
    end

    it 'returns unauthorized when email incorrect' do
      post :create, params: incorrect_email
      expect(response).to have_http_status(401)
    end
  end
end
