# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ComponentsController, type: :controller do
  let(:user) { create(:user) }
  let(:board) { create(:board, user: user) }

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET index' do
    let!(:components) { create_list(:component, 20, user: user, boards: [board]) }
    it 'returns a list of components' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]

      get :index
      json = JSON.parse(response.body)
  
      expect(response).to be_successful
      expect(json.length).to eq(20)
    end
  end

  describe 'GET show' do
    let!(:component) { create(:component, boards: [board], user: user) }

    it 'retrieves a component' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]

      get :show, params: { id: component.id }
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json['name']).to eq('test component name')
    end
  end

  describe 'POST create' do
    it 'creates a component' do
      name = ('a'..'z').to_a.shuffle[0, 10].join
      description = ('a'..'z').to_a.shuffle[0, 20].join

      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]

      expect {
        post :create, params: { component: { name: name,
                                             description: description } }
        }.to change(Component, :count).by(1)

      expect(response).to be_successful
      expect(Component.last.name).to eq(name)
      expect(Component.last.description).to eq(description)
    end

    it 'can return an error' do
      allow_any_instance_of(Component).to receive(:save).and_return(false)

      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]

      post :create, params: { component: { name: 'n', description: 'd' } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'PATCH update' do
    let!(:component) { create(:component, boards: [board], user: user) }
    it 'updates a component' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
  
      patch :update, params: {
        id: component.id,
        component: { name: 'new name', description: 'new description' }
      }

      expect(response).to be_successful
      component.reload
      expect(component.name).to eq('new name')
      expect(component.description).to eq('new description')
    end

    it 'can return an error' do
      allow_any_instance_of(Component).to receive(:update).and_return(false)

      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]

      patch :update, params: { id: component.id,
                               component: { name: 'another name' } }

      expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE destroy' do
    let!(:component) { create(:component, boards: [board], user: user) }

    it 'destroys a component' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]

      expect {
        delete :destroy, params: { id: Component.last.id }
      }.to change(Component, :count).by(-1)
    end

    it 'can return an error' do
      allow_any_instance_of(Component).to receive(:destroy).and_return(false)

      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]

      post :create, params: { component: { name: 'c' } }
      delete :destroy, params: { id: Component.last.id }

      expect(response).to have_http_status(422)
    end
  end
end
