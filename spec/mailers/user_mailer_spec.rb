# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user_email) { 'test@example.com' }

  describe 'rejection email' do
    let(:mail) { UserMailer.with(email: user_email).rejection_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Invitation rejected')
      expect(mail.to).to eq [user_email]
      expect(mail.from).to eq ['no-reply@brittle-pins.com']
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
      expect(mail.from).to eq ['no-reply@brittle-pins.com']
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/sign up|code/i)
    end
  end
end
