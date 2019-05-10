module Api::V1
  class ComponentsController < ApplicationController
    before_action :authorize_access_request!
    before_action :set_component, only: [:show, :update, :destroy]
  
    def index
      @components = current_user.components.order(:created_at)
      render json: @components
    end
  
    def show
      render json: @component
    end
  
    def create
      @component = current_user.components.new(component_params)
  
      if @component.save
        render json: @component, status: :created
      else
        render json: @component.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @component.update(component_params)
        render json: @component
      else
        render json: @component.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      if @component.destroy
        head :no_content, status: :ok
      else
        render json: @component.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_component
      @component = current_user.components.find(params[:id])
    end
  
    def component_params
      params.require(:component).permit(:name, :description)
    end
  end
end
