# frozen_string_literal: true

# Single-email mailer for sending updates about account
class UserMailer < ApplicationMailer
  before_action { @invitation = Invitation.where(email: params[:email]).first }

  def rejection_email
    @email = params[:email]
    mail(to: @email, subject: 'Invitation rejected')
  end

  def acceptance_email
    @email = params[:email]
    @invitation_code = @invitation&.code
    @expires_at = @invitation&.expires_at.to_date.to_formatted_s(:long_ordinal)
    mail(to: @email, subject: 'Invitation code for sign up')
  end
end
