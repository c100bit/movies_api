module Types
  class MovieType < Types::Base::Object
    field :id, ID, null: false
    field :title, String, null: false
    field :local_title, String, null: false
    field :year, Integer, null: false
    field :rate, Integer, null: false
    field :text, String, null: false
    field :image_url, String, null: false

    field :country, Types::CountryType, null: false, resolve: -> (movie, args, ctx) do
      BatchLoader::GraphQL.for(movie.country_id).batch do |country_ids, loader|
        Country.where(id: country_ids).each { |country| loader.call(country.id, country) }
      end
    end
    
    field :genres, [Types::GenreType], null: true, resolve: -> (movie, args, ctx) do
      BatchLoader::GraphQL.for(movie.id).batch(default_value: []) do |movie_ids, loader|
        genres_by_movie_id(movie_ids).each do |movie_id, genres|
          loader.call(movie_id) { |memo| memo.concat(genres) }
        end
      end
    end

    def self.genres_by_movie_id(parent_ids)
      result = Hash.new { |h, k| h[k] = [] }
      Genre.includes(:movies).each do |child| # potentially 1 sql with joins
        child.movies.each { |parent| result[parent.id] << child }
      end
      result # can use .each_with_object(...) instead of .each + result variable
    end

  end
end