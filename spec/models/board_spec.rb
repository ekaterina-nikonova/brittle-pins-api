# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:board_with_image) { build :board, :with_image }

  describe 'instance' do
    it 'is valid' do
      board = build(:board)
      expect(board.valid?).to be(true)
    end

    it 'can have components' do
      board = create(:board_with_components)
      expect(board.components.length).to eq(15)
    end

    it 'can have an image attached' do
      expect(board_with_image.image).to be_attached
    end
  end
end
