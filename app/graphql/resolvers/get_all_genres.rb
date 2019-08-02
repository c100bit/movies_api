module Resolvers
  class GetAllGenres < BaseResolver
    type [Types::GenreType], null: false

    def resolve
      Genre.all
    end
    
  end
end