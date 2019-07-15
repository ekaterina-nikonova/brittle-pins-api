# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Admin::Users::BoardsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:manager) { create(:user, role: :manager) }
  let!(:admin) { create(:user, role: :admin) }

  let!(:board_1) { create(:board, user: user) }
  let!(:board_2) { create(:board, user: user) }

  describe 'GET #index' do
    context 'when current user is admin' do
      it 'should get list of all boards for selected user' do
        sign_in_as(admin)
        get :index, params: { user_id: user.id }
        expect(response).to be_successful
        expect(response_json.size).to eq 2
      end
    end

    context 'when current user is manager' do
      it 'should not get list of boards for selected user' do
        sign_in_as(manager)
        get :index, params: { user_id: user.id }
        expect(response).not_to be_successful
      end
    end

    context 'when current user is user' do
      it 'should not get list of boards for selected user' do
        sign_in_as(user)
        get :index, params: { user_id: user.id }
        expect(response).not_to be_successful
      end
    end
  end
end
