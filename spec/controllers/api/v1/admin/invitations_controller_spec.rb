# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Admin::InvitationsController, type: :controller do
  let!(:admin) { create(:user, role: :admin) }
  let!(:manager) { create(:user, role: :manager) }
  let!(:user) { create(:user) }
  let(:data) { { email: 'test@test.com' } }
  let(:data2) { { email: 'test2@test.com' } }

  describe 'POST #create' do
    it 'should create an invitation' do
      post :create, params: data
      expect(response).to be_successful
      expect(response).to have_http_status(201)
    end

    it 'should not create invitation if email is taken by User' do
      post :create, params: { email: user.email }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should not create invitation if email is used in Invitations' do
      post :create, params: data
      expect(response).to be_successful

      post :create, params: data
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should generate an 8-character code' do
      post :create, params: data
      expect(Invitation.last[:code].length).to eq 8
    end

    it 'should create an invitation for the specified email' do
      post :create, params: data
      expect(Invitation.last[:email]).to eq data[:email]
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      sign_in_as(admin)
      post :create, params: data
    end

    context 'when current user is admin' do
      it 'should delete invitation with the provided id' do
        expect do
          delete :destroy, params: { id: Invitation.last.id }
        end.to change(Invitation, :count).by(-1)
        expect(response).to have_http_status(204)
      end
    end

    context 'when current user is manager' do
      it 'should delete invitation with the provided id' do
        sign_in_as(manager)
        expect do
          delete :destroy, params: { id: Invitation.last.id }
        end.to change(Invitation, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when current user is user' do
      it 'should not delete invitation' do
        sign_in_as(user)
        expect do
          delete :destroy, params: { id: Invitation.last.id }
        end.to change(Invitation, :count).by(0)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'GET #index' do
    before :each do
      post :create, params: data
      post :create, params: data2
    end

    context 'when current user is admin' do
      it 'should show list of all invitations' do
        sign_in_as(admin)
        get :index
        expect(response).to be_successful
        expect(response_json.length).to eq(2)
      end

      it 'should only show id, code, and email (in this order)' do
        sign_in_as(admin)
        get :index
        expect(response_json.first.keys).to eq %w[id code email]
      end
    end

    context 'when current user is manager' do
      it 'should show list of all invitations' do
        sign_in_as(manager)
        get :index
        expect(response).to be_successful
        expect(response_json.length).to eq(2)
      end
    end

    context 'when current user is user' do
      it 'should not show list of invitations' do
        sign_in_as(user)
        get :index
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
