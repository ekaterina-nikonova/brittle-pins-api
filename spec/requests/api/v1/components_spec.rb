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

  describe 'POST create' do
    it 'creates a component' do
      name = ('a'..'z').to_a.shuffle[0, 10].join
      description = ('a'..'z').to_a.shuffle[0, 20].join

      post :create, params: { component: { name: name,
                                           description: description } }

      expect(response).to be_successful
      expect(Component.last.name).to eq(name)
      expect(Component.last.description).to eq(description)
    end

    it 'can return an error' do
      allow_any_instance_of(Component).to receive(:save).and_return(false)
      post :create, params: { component: { name: 'n', description: 'd' } }
      expect(response).not_to be_successful
    end
  end

  describe 'PATCH update' do
    it 'updates a component' do
      component = build(:component)
      component.save
  
      patch :update, params: {
        id: component.id,
        component: { name: 'new name', description: 'new description' }
      }
      expect(Component.last.name).to eq('new name')
      expect(Component.last.description).to eq('new description')
    end

    it 'can return an error' do
      component = build(:component)
      component.save

      allow_any_instance_of(Component).to receive(:update).and_return(false)
      patch :update, params: { id: component.id,
                               component: { name: 'another name' } }
      expect(response).not_to be_successful
    end
  end
end
