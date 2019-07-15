# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Admin::UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:manager) { create(:user, role: :manager) }
  let!(:admin) { create(:user, role: :admin) }

  describe 'GET #index' do
    context 'when current user is admin' do
      it 'can get list of all users' do
        sign_in_as(admin)
        get :index
        expect(response).to be_successful
        expect(response_json.size).to eq 3
      end
    end
  end

  context 'when current user is manager' do
    it 'can get list of all users' do
      sign_in_as(manager)
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 3
    end
  end

  context 'when current user is user' do
    it 'cannot get list of all users' do
      sign_in_as(user)
      get :index
      expect(response).not_to be_successful
      expect(response).to have_http_status 403
    end
  end
end

