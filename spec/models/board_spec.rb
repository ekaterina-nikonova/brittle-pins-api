# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  describe 'instance' do
    it 'is valid' do
      board = build(:board)
      expect(board.valid?).to be(true)
    end

    it 'can have components' do
      board = create(:board_with_components)
      expect(board.components.length).to eq(15)
    end
  end
end
