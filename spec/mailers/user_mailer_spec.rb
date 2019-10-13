require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'rejection_email' do
    let(:user_email) { 'test@example.com' }
    let(:mail) { UserMailer.with(email: user_email).rejection_email }

    it 'renders the headers' do
      expect(mail.subject).not_to be('Invitation rejected')
      expect(mail.to).to eq [user_email]
      expect(mail.from).to eq ['no-reply@brittle-pins.com']
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/reject|access/i)
    end
  end
end
