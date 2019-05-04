# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ComponentsController, type: :controller do
  describe 'GET index' do
    it 'returns a list of components' do
      board = build(:board)
      create_list(:component, 20, boards: [board])
      
      get :index
      json = JSON.parse(response.body)
  
      expect(response).to be_successful
      expect(json.length).to eq(20)
    end
  end

  describe 'GET show' do
    it 'retrieves a component' do
      component = build(:component)
      component.save

      get :show, params: { id: component.id }
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json['name']).to eq('test component name')
    end
  end
end
