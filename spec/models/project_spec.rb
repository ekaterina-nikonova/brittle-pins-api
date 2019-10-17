require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'instance' do
    it 'is valid' do
      project = build(:project)
      expect(project.valid?).to be(true)
    end
  end
end
