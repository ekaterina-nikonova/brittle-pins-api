# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do
  let(:user) { create :user }
  let(:board) { create :board, user: user }
  let(:project) { build :project, user: user }

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET index' do
    let!(:projects) { create_list(:project, 20, user: user, board: board) }

    it 'is unauth without a cookie' do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns a list of projects' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index

      expect(response).to be_successful
      expect(response_json.length).to eq(20)
    end
  end
end
