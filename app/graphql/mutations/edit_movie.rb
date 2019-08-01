module Mutations
  class EditMovie < BaseMutation
    argument :title, String, required: true
    argument :local_title, String, required: true
    argument :text, String, required: true
    argument :year, Integer, required: true
    argument :rate, Integer, required: true
    argument :country_id, ID, required: true
    argument :genre_ids, [ID], required: true
    argument :image, [ApolloUploadServer::Upload], required: true

    type Types::MovieType

    def resolve(id:, params)
      movie = Movie.find(id)
      movie.update(params)
      movie
    end
    
  end
end