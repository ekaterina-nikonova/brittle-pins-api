module Api::V1
  class ProjectsController < ApplicationController
    before_action :authorize_access_request!, only: [:index]

    def index
      render json: current_user.projects.order(:created_at).reverse_order
    end

    def public
      render json: Project.where(public: true)
    end
  end
end
