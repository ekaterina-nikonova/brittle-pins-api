# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::BoardsController, type: :controller do
  let(:board_with_image) { build :board, :with_image }

  describe 'GET index' do
    it 'returns a list of boards' do
      create_list(:board, 10)
  
      get :index
      json = JSON.parse(response.body)
  
      expect(response).to be_successful
      expect(json.length).to eq(10)
    end
  end

  describe 'GET show' do
    it 'retrieves a specific board' do
      board_with_image.save
      id = Board.last.id
      
      get :show, params: { id: id }
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["image"]).not_to be_nil
    end
  end
end
