# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user_email) { 'test@example.com' }
  let!(:invitation) { create(:invitation) }

  describe 'rejection email' do
    let(:mail) { UserMailer.with(email: user_email).rejection_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Invitation rejected')
      expect(mail.to).to eq [user_email]
      expect(ApplicationMailer.default[:from]).to match(mail.from.to_s)
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/reject|access/i)
    end
  end

  describe 'acceptance email' do
    let(:mail) { UserMailer.with(email: user_email).acceptance_email }

    it 'renders the headers' do
      expect(mail.subject).to match(/invitation/i)
      expect(mail.to).to eq [user_email]
      expect(ApplicationMailer.default[:from]).to match(mail.from.to_s)
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/sign up|code/i)
      expect(mail.body.encoded)
        .to match(1.year.from_now.to_date.to_formatted_s(:long_ordinal))
    end
  end
end
