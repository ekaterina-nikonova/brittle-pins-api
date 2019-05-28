class BoardsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'boards_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
