module Resolvers
  class OrderMovies < BaseResolver
    type [Types::MovieType], null: false

    argument :by, String, required: true
    argument :asc, Boolean, required: true

    def resolve(by:, asc:)
      if by == 'year' || by == 'rate'
        direction = asc ? 'ASC' : 'DESC'
        Movie.order("#{by} #{direction}")
      else
        Movie.all
      end
    end
    
  end
end

