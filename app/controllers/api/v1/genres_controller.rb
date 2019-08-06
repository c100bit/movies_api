module Api::V1
  class GenresController < BaseController

    # GET /v1/genres
    def index
      render json: Genre.all
    end

  end
end