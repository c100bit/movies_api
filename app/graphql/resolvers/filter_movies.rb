module Resolvers
  class FilterMovies < BaseResolver
    type [Types::MovieType], null: false

    argument :field, String, required: true
    argument :val, String, required: true

    def resolve(field:, val:)
      case field
      when 'genre_ids'
        Movie.filter_by_genres(val.split(','))
      when 'title'
        Movie.filter_by_title(val)
      when 'year', 'country_id', 'rate'
        Movie.filter_by(field, val) 
      else
        Movie.all
      end
    end
  end
end
 
  