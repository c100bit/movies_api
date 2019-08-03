module Root
  class QueryType < Types::Base::Object

    field :movies, 
      resolver: Resolvers::GetAllMovies,
      description: "Get all movies"

    field :movie, 
      resolver: Resolvers::GetOneMovie,
      description: "Get movie by id"

    field :filter_movies, 
      resolver: Resolvers::FilterMovies,
      description: "Filter movies (field: title|year|country_id|rate|genre_ids)"

    field :order_movies,
      resolver: Resolvers::OrderMovies,
      description: "Order movies (by: year|rate, asc: true|false)"

    field :countries, 
      resolver: Resolvers::GetAllCountries,
      description: "Get all countries"

    field :genres,
      resolver: Resolvers::GetAllGenres,
      description: "Get all genres"

  end
end
