module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :channel_user

    def connect
      @channel_user = nil
      return unless cookies[:user_id]

      @channel_user = User.find(cookies[:user_id]) if cookies[:user_id]
    end
  end
end
