# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Admin::Users::ComponentsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:manager) { create(:user, role: :manager) }
  let!(:admin) { create(:user, role: :admin) }

  let!(:board) { create(:board, user: user) }
  let!(:component_1) { create(:component, user: user, boards: [board]) }
  let!(:component_2) { create(:component, user: user, boards: [board]) }

  describe 'GET #index' do
    context 'when current user is admin' do
      it 'should get list of all components for selected user' do
        sign_in_as(admin)
        get :index, params: { user_id: user.id }
        expect(response).to be_successful
        expect(response_json.size).to eq 2
      end
    end

    context 'when current user is manager' do
      it 'should not get list of all components for selected user' do
        sign_in_as(manager)
        get :index, params: { user_id: user.id }
        expect(response).not_to be_successful
        expect(response).to have_http_status(403)
      end
    end

    context 'when current user is user' do
      it 'should not get list of all components for selected user' do
        sign_in_as(user)
        get :index, params: { user_id: user.id }
        expect(response).not_to be_successful
        expect(response).to have_http_status(403)
      end
    end
  end
end
