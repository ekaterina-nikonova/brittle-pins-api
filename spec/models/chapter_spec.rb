require 'rails_helper'

RSpec.describe Chapter, type: :model do
  let!(:user) { create(:user) }
  let!(:board) { create(:board, user: user) }

  let(:project) { build :project, board: board, user: user }
  let(:chapter) { build :chapter, project: project }

  describe 'instance' do
    it 'should be valid' do
      expect(chapter.valid?).to be(true)
    end

    it 'should have a name' do
      expect(chapter.name).to eq('test chapter')

      chapter.name = nil
      expect(chapter).not_to be_valid
    end

    it 'can have an intro' do
      expect(chapter.intro).to eq('test chapter intro')

      chapter.intro = nil
      expect(chapter).to be_valid
    end
  end
end
