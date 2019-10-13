# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SignupController, type: :controller do
  describe 'POST create' do
    let(:user) { build :user }
    let(:admin) { build :user, role: :admin }
    let(:user_params) do
      { username: user.username,
        email: user.email,
        password: user.password,
        password_confirmation: user.password }
    end
    let!(:invitation) { create :invitation }

    it 'should fail if no invitation code provided' do
      expect { post :create, params: user_params }
        .to raise_error ActionController::ParameterMissing
    end

    it 'should fail if invitation code does not match email' do
      invitation.validate
      post :create, params: user_params.merge(invitation_code: 'random_code')
      expect(response).to have_http_status(403)
    end

    it 'should succeed if invitation code matches email' do
      post :create, params: user_params.merge(invitation_code: invitation.code)
      expect(response).to have_http_status(200)
    end

    it 'should change invitation used_at datetime' do
      post :create, params: user_params.merge(invitation_code: invitation.code)
      invitation.reload
      expect(invitation.used_at.nil?).to eq(false)
    end

    it 'should set used_at datetime in the future' do
      post :create, params: user_params.merge(invitation_code: invitation.code)
      invitation.reload
      expect(invitation.used_at.after? invitation.created_at).to be(true)
    end

    it 'returns http success' do
      post :create, params: user_params.merge(invitation_code: invitation.code)
      expect(response).to be_successful
      expect(response_json.keys).to eq ['csrf']
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'creates a new user' do
      expect do
        post :create, params: user_params.merge(invitation_code: invitation.code)
      end.to change(User, :count).by(1)
    end
  end
end
