# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in_as(user) }

  describe "GET #me" do
    let!(:board) { create(:board, user: user) }

    it "returns http success" do
      get :me
      expect(response).to have_http_status(:success)
      expect(response_json).to eq user.as_json(only: [:id, :email, :username, :role])
    end
  end

end
