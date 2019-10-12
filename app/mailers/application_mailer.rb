# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@brittle-pins.com'
  layout 'mailer'
end
