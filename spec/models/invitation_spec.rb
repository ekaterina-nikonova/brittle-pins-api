# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invitation, type: :model do
  let!(:invitation) { create(:invitation) }

  describe 'instance' do
    it 'should be valid' do
      expect(invitation.valid?).to be(true)
    end

    it 'should have an expiry date greater than creation date' do
      expect(invitation.created_at.before?(invitation.expires_at)).to be(true)
    end

    it 'should have a code' do
      expect(invitation.code).not_to be_empty
    end
  end
end
