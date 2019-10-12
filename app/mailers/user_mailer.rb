# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def rejection_email
    @email = params[:email]
    mail(to: @email, subject: 'Invitation rejected')
  end
end
