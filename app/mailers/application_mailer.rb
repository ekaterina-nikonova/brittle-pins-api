# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Brittle Pins <admin@brittle-pins.com>'
  layout 'mailer'
end
