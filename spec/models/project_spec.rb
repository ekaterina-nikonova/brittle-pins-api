require 'rails_helper'

RSpec.describe Project, type: :model do
  let!(:user) { create(:user) }

  describe 'instance' do
    it 'is invalid without a user' do
      project = build(:project)
      expect(project.valid?).to be(false)
    end

    it 'belongs to user' do
      project = user.projects.new name: 'Test project', description: 'Test description'
      expect(project.valid?).to be(true)
      expect(project.user).not_to be(nil)
    end
  end
end
