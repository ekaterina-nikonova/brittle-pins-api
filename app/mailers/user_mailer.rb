# frozen_string_literal: true

# Single-email mailer for sending updates about account
class UserMailer < ApplicationMailer
  def rejection_email
    @email = params[:email]
    mail(to: @email, subject: 'Invitation rejected')
  end

  def acceptance_email
    #
  end
end
