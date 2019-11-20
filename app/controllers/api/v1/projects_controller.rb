module Api::V1
  class ProjectsController < ApplicationController
    before_action :authorize_access_request!

    def index
      render json: current_user.projects.order(:created_at).reverse_order
    end
  end
end
