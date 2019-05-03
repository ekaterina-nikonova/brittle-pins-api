# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  describe 'Board' do
    it 'is valid' do
      board = Board.new
      expect(board.valid?).to be(true)
    end
  end
end
