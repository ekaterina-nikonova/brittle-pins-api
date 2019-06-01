module Api::V1
  class BoardsController < ApplicationController
    before_action :authorize_access_request!
    before_action :set_board, only: [:show, :update, :destroy]
  
    def index
      @boards = current_user.boards.order(:created_at)

      boards_with_images = @boards.map do |board|
        with_image(board)
      end
      render json: boards_with_images
    end
  
    def show
      render json: with_image(@board)
    end
  
    def create
      @board = current_user.boards.new(board_params)
  
      if @board.save
        ActionCable.server.broadcast 'boards_channel', { action: :create, data: @board }
        render json: @board, status: :created
      else
        render json: @board.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @board.update(board_params)
        ActionCable.server.broadcast 'boards_channel', { action: :update, data: with_image(@board) }
        render json: @board, status: :created
      else
        render json: @board.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      if @board.destroy
        ActionCable.server.broadcast 'boards_channel', action: :destroy, data: @board
        head :no_content, status: :ok
      else
        render json: @board.errors, status: :unprocessable_entity
      end
    end

    def components
      render json: Board.find(params[:board_id]).components
    end
  
    private
  
    def set_board
      @board = current_user.boards.find(params[:id])
    end
  
    def board_params
      params.require(:board).permit(:name, :description)
    end

    def with_image board
      if board.image.attached?
        board.attributes.merge({ image: url_for(board.image) })
      else
        board
      end
    end
  end
end
