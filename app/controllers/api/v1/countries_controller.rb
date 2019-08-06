module Api::V1
  class CountriesController < BaseController

    # GET /v1/countries
    def index
      render json: Country.all
    end

  end
end