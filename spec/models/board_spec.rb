# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:user) { build :user }
  let(:board_with_image) { build :board, :with_image, user: user }

  describe 'instance' do
    it 'is valid' do
      board = build(:board, user: user)
      expect(board.valid?).to be(true)
    end

    it 'can have projects' do
      board = create(:board_with_projects, user: user)
      expect(board.projects.length).to eq(13)
    end

    it 'can have components' do
      board = create(:board_with_components, user: user)
      expect(board.components.length).to eq(15)
    end

    it 'can have an image attached' do
      expect(board_with_image.image).to be_attached
    end
  end
end
