# frozen_string_literal: true

require 'rails_helper'

describe 'Boards API' do
  it 'returns a list of boards' do
    create_list(:board, 10)

    get '/api/v1/boards'
    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json.length).to eq(10)
  end
end
