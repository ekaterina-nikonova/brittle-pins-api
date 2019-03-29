module Api::V1
  class BoardsController < ApplicationController
    before_action :set_board, only: [:show, :update, :destroy]
  
    def index
      @boards = Board.order(:created_at)

      boards_with_images = @boards.map do |board|
        with_image(board)
      end
      render json: boards_with_images
    end
  
    def show
      render json: with_image(@board)
    end
  
    def create
      @board = Board.new(board_params)
  
      if @board.save
        render json: @board, status: :created
      else
        render json: @board.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @board.update(board_params)
        render json: @board
      else
        render json: @board.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      if @board.destroy
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
      @board = Board.find(params[:id])
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
