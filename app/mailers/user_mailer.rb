# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def invitation_email
    mail to: 'admin@brittle-pins.com', subject: 'Test from Rails console'
  end
end
