module Resolvers
  class GetAllMovies < BaseResolver
    type [Types::MovieType], null: false

    def resolve
      Movie.all
    end
    
  end
end