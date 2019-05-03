# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  describe 'instance' do
    it 'is valid' do
      board = build(:board)
      expect(board.valid?).to be(true)
    end
  end
end
