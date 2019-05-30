require 'aws-sdk-s3'

module Api::V1
  class UploadsController < ApplicationController
    before_action :authorize_access_request!
    before_action :set_upload, only: [:create]

    def create
      file = @upload.original_filename

      if upload_params[:type].eql? 'image'
        unless is_image? @upload.original_filename
          render_wrong_format_error
          return
        end
      end

      @parent.send(upload_params[:type]).attach(upload_params[:file])

      response = { data: { error: nil, url: url_for(@parent.send(upload_params[:type])) }}

      ActionCable.server.broadcast set_channel(@parent),
                                   { action: 'update', data: @parent.attributes }
      render json: response
    end

    private

    def is_image? filename
      regex = Regexp.union(/.\.png$/i, /.\.jpg$/i, /.\.jpeg$/i)
      filename.match regex
    end

    def render_wrong_format_error
      render json: { data: { error: 'Wrong file format' } },
             status: :unprocessable_entity
    end

    def set_upload
      @upload = upload_params['file']

      parent = { type: upload_params['parent'].capitalize,
                 id: upload_params['parent_id'] }

      table = parent[:type].constantize.table_name.to_sym
      @parent = current_user.send(table).find(parent[:id])
    end

    def upload_params
      params.permit(:file, :parent, :parent_id, :type)
    end

    def set_channel(parent)
      return "#{parent.class.table_name}_channel"
    end
  end
end
