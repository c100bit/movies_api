module Root
  class QueryType < Types::Base::Object

    field :movies, [Types::MovieType], null: false,
      description: "Get all movies"
    def movies
      Movie.all
    end

    field :movie, Types::MovieType, null: true, 
      description: "Get movie by id" do
      argument :id, ID, required: true
    end

    field :countries, [Types::CountryType], null: false,
      description: "Get all countries"
    def countries
      Country.all
    end

    field :genres, [Types::GenreType], null: false,
      description: "Get all genres"
    def genres
      Genre.all
    end


  end
end
