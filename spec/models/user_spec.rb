require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create :user }

  describe 'instance' do
    it 'is valid' do
      expect(user.valid?).to be(true)
    end
  end
end
