# frozen_string_literal: true

class DeleteGuestsJob < ApplicationJob
  queue_as :default

  def perform
    User.where('role = ? and created_at < ?', 0, 1.hour.ago).destroy_all
  end
end
