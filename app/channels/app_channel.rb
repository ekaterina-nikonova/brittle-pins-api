class AppChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from 'app_channel'
  end

  def unsubscribed
    stop_all_streams
  end
end
