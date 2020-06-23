module Api
  module V1
    class ImagesController < ApplicationController
      def upload
        image = Cloudinary::Uploader.upload(params[:image])
        render json: { image: image }, status: :ok
      rescue => error
        render json: { message: error.message }, status: :unprocessable_entity
      end
    end
  end
end
