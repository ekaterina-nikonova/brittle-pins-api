require 'rails_helper'

RSpec.describe Section, type: :model do
  let!(:user) { create(:user) }
  let!(:board) { create(:board, user: user) }

  let(:project) { build :project, board: board, user: user }
  let(:chapter) { build :chapter, project: project, user: user }
  let(:section) { build :section, chapter: chapter, user: user }
  let(:section_with_image) { build :section, :with_image }

  describe 'instance' do
    it 'is valid' do
      expect(section.valid?).to be(true)
    end

    it 'should have a paragraph' do
      expect(section.paragraph).to eq('test section paragraph')
    end

    it 'should have code' do
      expect(section.code).to eq('test section code')
    end

    it 'should have language' do
      expect(section.language).to eq('sectionlang')
    end

    it 'should be invalid without a paragraph' do
      section.paragraph = nil
      expect(section).not_to be_valid
    end

    it 'should be invalid without a chapter' do
      expect(section.chapter).not_to be(nil)

      section.chapter = nil
      expect(section).not_to be_valid
    end

    it 'can have an image attached' do
      expect(section_with_image.image).to be_attached
    end
  end
end
