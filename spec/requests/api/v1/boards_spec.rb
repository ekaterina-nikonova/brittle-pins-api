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

  describe 'POST create' do
    it 'creates a board' do
      name = ('a'..'z').to_a.shuffle[0, 10].join
      description = ('a'..'z').to_a.shuffle[0, 20].join

      post :create, params: { board: { name: name,
                                       description: description } }
      expect(Board.last.name).to eq(name)
      expect(Board.last.description).to eq(description)
    end
  end

  describe 'PATCH update' do
    it 'updates a board' do
      post :create, params: { board: { name: 'name 1',
                                       description: 'description 1'} }
      id = Board.last.id

      patch :update, params: { id: id,
                               board: { name: 'name 2',
                                        description: 'description 2'} }
      expect(Board.last.name).to eq('name 2')
      expect(Board.last.description).to eq('description 2')
    end
  end

  describe 'DELETE destroy' do
    it 'destroys a board' do
      post :create, params: { board: { name: '' } }
      expect(Board.all.length).to eq(1)

      id = Board.last.id

      delete :destroy, params: { id: id }
      expect(Board.all.length).to eq(0)
    end
  end

  describe 'GET components' do
    it 'retrieves components for a board' do
      board = create(:board_with_components)
      get :components, params: { board_id: board.id }
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json.length).to eq(15)
    end
  end
end
