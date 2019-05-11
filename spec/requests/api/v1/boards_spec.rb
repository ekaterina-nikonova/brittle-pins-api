# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::BoardsController, type: :controller do
  let(:board_with_image) { build :board, :with_image }
  let(:user) { create(:user) }
  let(:board_attrs) {
    { name: 'test board', description: 'test descr' }
  }

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET index' do
    let!(:board) { create(:board, user: user) }

    it 'returns a list of boards' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
  
      get :index
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json.length).to eq(1)
    end

    it 'is unauth without cookie' do
      get :index
      expect(response).to have_http_status(401)
    end
  end

  describe 'GET show' do
    let!(:board) { create(:board, :with_image, user: user) }

    it 'retrieves a specific board' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]

      get :show, params: { id: Board.last.id }
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["image"]).not_to be_nil
    end
  end

  describe 'POST create' do
    it 'creates a board' do
      name = ('a'..'z').to_a.shuffle[0, 10].join
      description = ('a'..'z').to_a.shuffle[0, 20].join

      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]

      expect {
        post :create, params: { board: { name: name,
                                       description: description },
                                       user: user }
        }.to change(Board, :count).by(1)
      expect(Board.last.name).to eq(name)
      expect(Board.last.description).to eq(description)
    end

    it 'can return an error' do
      allow_any_instance_of(Board).to receive(:save).and_return(false)

      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]

      post :create, params: { board: { name: 'a', description: 'b' } }
      expect(response.status).to eq(422)
    end
  end

  describe 'PATCH update' do
    let!(:board) { create(:board, user: user) }

    it 'updates a board' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]

      patch :update, params: { id: board.id,
                               board: { name: 'name 2',
                               description: 'description 2'} }
      
      expect(response).to be_successful
      board.reload
      expect(board.name).to eq('name 2')
      expect(board.description).to eq('description 2')
    end

    it 'can return an error' do
      allow_any_instance_of(Board).to receive(:update).and_return(false)

      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]

      patch :update, params: { id: board.id, board: { name: 'new name' } }
      expect(response.status).to eq(422)
    end
  end

  describe 'DELETE destroy' do
    let!(:board) { create(:board, user: user) }
    it 'destroys a board' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]

      expect {
        delete :destroy, params: { id: board.id }
      }.to change(Board, :count).by(-1)
    end

    it 'can return an error' do
      allow_any_instance_of(Board).to receive(:destroy).and_return(false)
      
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]

      delete :destroy, params: { id: board.id }
      expect(response.status).to eq(422)
    end
  end

  describe 'GET components' do
    it 'retrieves components for a board' do
      board = create(:board_with_components, user: user)

      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :components, params: { board_id: board.id }
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json.length).to eq(15)
    end
  end
end
