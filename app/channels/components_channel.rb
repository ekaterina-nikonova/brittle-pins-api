class ComponentsChannel < ApplicationCable::Channel
  def subscribed
    board = Board.find(params[:board_id])
    stream_for board
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
