# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Brittle Pins <no-reply@brittle-pins.com>'
  layout 'mailer'
end
