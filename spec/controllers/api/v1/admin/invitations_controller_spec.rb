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

  describe 'DELETE #destroy_with_rejection' do
    before :each do
      post :create, params: data
    end

    it 'should send email' do
      ActiveJob::Base.queue_adapter = :test

      sign_in_as(admin)
      expect do
        delete :destroy_with_rejection, params: { id: Invitation.last.id }
      end.to have_enqueued_job.on_queue('mailers')
    end
  end

  describe 'PATCH #accept' do
    before :each do
      post :create, params: data
    end

    it 'should change accepted_at attribute' do
      sign_in_as(admin)
      patch :accept, params: { id: Invitation.last.id }
      expect(Invitation.last.accepted_at).not_to be(nil)
    end

    it 'should send email' do
      ActiveJob::Base.queue_adapter = :test
      sign_in_as(admin)

      expect do
        patch :accept, params: { id: Invitation.last.id }
      end.to have_enqueued_job.on_queue('mailers')
    end

    it 'should change expiry date to a week' do
      sign_in_as(admin)
      patch :accept, params: { id: Invitation.last.id }
      expect(Invitation.last.expires_at.end_of_day).to eq(1.week.from_now.end_of_day)
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

      it 'should only include selected attributes' do
        attributes = %w[id code email created_at accepted_at used_at]
        sign_in_as(admin)

        get :index
        expect((response_json.first.keys.difference attributes).any?).to be(false)
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
