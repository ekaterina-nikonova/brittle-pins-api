class BoardsChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from 'boards_channel'
  end

  def unsubscribed
    stop_all_streams
  end
end
