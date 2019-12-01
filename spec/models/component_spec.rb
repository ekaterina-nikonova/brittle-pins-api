require 'rails_helper'

RSpec.describe Component, type: :model do
  let!(:user) { create(:user) }
  let!(:board) { create(:board, user: user) }

  describe 'instance' do
    it 'can have projects' do
      component = create(:component_with_projects, user: user, boards: [board])
      expect(component.projects.count).to eq(19)
    end
  end
end
