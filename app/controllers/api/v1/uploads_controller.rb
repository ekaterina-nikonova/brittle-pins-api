require 'aws-sdk-s3'

module Api::V1
  class UploadsController < ApplicationController
    pp '---***--- 0 ---***---'
    before_action :authorize_access_request!
    pp '---***--- 0.5 ---***---'
    before_action :set_upload, only: [:create]

    def create
      pp '---***--- 1 ---***---'
      file = @upload.original_filename

      pp '---***--- 2 ---***---'
      if upload_params[:type].eql? 'image'
        pp '---***--- 3 ---***---'

        unless is_image? @upload.original_filename
          pp '---***--- 4 ---***---'

          render_wrong_format_error
          return
        end
      end

      pp '---***--- 5 ---***---'

      @parent.send(upload_params[:type]).attach(upload_params[:file])

      pp '---***--- 6 ---***---'
      response = { data: { error: nil, url: url_for(@parent.image) }}
      render json: response      
    end

    private

    def is_image? filename
      pp '---***--- 7 ---***---'
      regex = Regexp.union(/.\.png$/i, /.\.jpg$/i, /.\.jpeg$/i)
      filename.match regex
    end

    def render_wrong_format_error
      pp '---***--- 8 ---***---'
      render json: { data: { error: 'Wrong file format' } },
             status: :unprocessable_entity
    end

    def set_upload
      pp '---***--- 9 ---***---'
      @upload = upload_params['file']

      pp '---***--- 10 ---***---'
      parent = { type: upload_params['parent'].capitalize,
                 id: upload_params['parent_id'] }
      pp '---***--- 11 ---***---'

      table = parent[:type].constantize.table_name.to_sym
      pp '---***--- 12 ---***---'
      @parent = current_user.send(table).find(parent[:id])
    end

    def upload_params
      pp '---***--- 13 ---***---'
      params.permit(:file, :parent, :parent_id, :type)
    end
  end
end
