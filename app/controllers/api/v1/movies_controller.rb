module Api::V1
  class MoviesController < BaseController
    before_action :set_movie, only: [:show, :update, :destroy]

    # GET /v1/movies
    def index
      if params[:order].present?
        @movies = _order_by(params[:order], params[:asc]) #desc default
      elsif params[:filter].present?
        @movies = _filter_by(params[:filter], params[:val])
      end
      @movies = Movie.all unless @movies
      render json: @movies.with_attached_image
    end

    # GET /v1/movies/1
    def show
      render json: @movie
    end

    # POST /v1/movies
    def create
      @movie = Movie.new(movie_params)

      if @movie.save
        movie_path = api_v1_movie_path(@movie)
        render json: @movie, status: :created, location: movie_path
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /v1/movies/1
    def update
      if @movie.update(movie_params)
        render json: @movie
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
    end 
 
    # DELETE /v1/movies/1
    def destroy
      @movie.destroy 
    end

  private

    def _order_by field, asc
      if field == 'year' || field == 'rate'
        direction = asc ? 'ASC' : 'DESC'
        Movie.order("#{field} #{direction}")
      end
    end

    def _filter_by field, val
      return if val.nil?
      case field
      when 'genre_ids'
        Movie.filter_by_genres(val.split(','))
      when 'title'
        Movie.filter_by_title(val)
      when 'year', 'country_id', 'rate'
        Movie.filter_by(field, val) 
      end
    end

    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :local_title, :rate, :text,
         :year, :country_id, :image, genre_ids: [])
    end

  end
end