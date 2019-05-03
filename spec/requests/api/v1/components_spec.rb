# frozen_string_literal: true

require 'rails_helper'

describe 'Components API' do
  it 'returns a list of components' do
    board = build(:board)
    create_list(:component, 20, boards: [board])
    
    get '/api/v1/components'
    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json.length).to eq(20)
  end
end
