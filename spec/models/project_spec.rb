require 'rails_helper'

RSpec.describe Project, type: :model do
  let!(:user) { create(:user) }
  let!(:board) { create(:board, user: user) }

  describe 'instance' do
    it 'is invalid without a user' do
      project = build(:project)
      expect(project.valid?).to be(false)
    end

    it 'belongs to a user' do
      project = build(:project, user: user, board: board)
      expect(project.valid?).to be(true)
      expect(project.user).not_to be(nil)
    end

    it 'belongs to a board' do
      project = build(:project, user: user, board: board)
      expect(project.valid?).to be(true)
      expect(project.board).not_to be(nil)
    end

    it 'can have components' do
      project = create(:project_with_components, user: user, board: board)
      expect(project.components.length).to eq(18)
    end

    it 'can have many chapters' do
      project = create(:project_with_chapters, user: user, board: board)
      expect(project.chapters.count).to eq(11)
    end
  end
end
