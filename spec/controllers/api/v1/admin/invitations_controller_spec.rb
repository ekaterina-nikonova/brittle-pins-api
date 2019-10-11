# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Admin::InvitationsController, type: :controller do
  let!(:admin) { create(:user, role: :admin) }
  let!(:manager) { create(:user, role: :manager) }
  let!(:user) { create(:user) }
  let(:data) { { email: 'test@test.com' } }

  describe 'POST #create' do
    context 'when current user is admin' do
      it 'should create an invitation' do
        sign_in_as(admin)
        post :create, params: data
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it 'should create an invitation belonging to the current user' do
        sign_in_as(admin)
        post :create, params: data
        expect(Invitation.last.user_id).to eq admin.id
      end

      it 'should generate an 8-character code' do
        sign_in_as(admin)
        post :create, params: data
        expect(response_json['code'].length).to eq 8
      end

      it 'should create an invitation for the specified email' do
        sign_in_as(admin)
        post :create, params: data
        expect(response_json['email']).to eq data[:email]
      end

      it 'should invoke mailer' do
        allow(::UserMailer).to receive(:with)
        sign_in_as(admin)
        post :create, params: data
        expect(::UserMailer).to have_received(:with)
      end

      it 'should pass invitation to mailer' do
        allow(::UserMailer).to receive(:with)
        sign_in_as(admin)
        post :create, params: data
        expect(::UserMailer).to have_received(:with).with(Invitation.last)
      end

      it 'should call invitation email' do
        allow(::UserMailer).to receive_message_chain(:with, :invitation_email)
        sign_in_as(admin)
        post :create, params: data
        expect(::UserMailer.with(*args)).to have_received(:invitation_email)
      end
    end

    context 'when current user is manager' do
      it 'should create an invitation' do
        sign_in_as(manager)
        post :create, params: data
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context 'when current user is user' do
      it 'should not create an invitation' do
        sign_in_as(user)
        post :create, params: data
        expect(response).not_to be_successful
        expect(response).to have_http_status(403)
      end
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
      it 'should not delete invitation' do
        sign_in_as(manager)
        expect do
          delete :destroy, params: { id: Invitation.last.id }
        end.to change(Invitation, :count).by(0)
        expect(response).to have_http_status(401)
      end
    end

    context 'when current user is user' do
      it 'should not delete invitation' do
        sign_in_as(user)
        expect do
          delete :destroy, params: { id: Invitation.last.id }
        end.to change(Invitation, :count).by(0)
        expect(response).to have_http_status(401)
      end
    end
  end
end
