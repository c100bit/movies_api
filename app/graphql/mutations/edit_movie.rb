module Mutations
  class EditMovie < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :local_title, String, required: false
    argument :text, String, required: false
    argument :year, Integer, required: false
    argument :rate, Integer, required: false
    argument :country_id, ID, required: false
    argument :genre_ids, [ID], required: false
    argument :image, [ApolloUploadServer::Upload], required: false

    type Types::MovieType

    def resolve(params)
      movie = Movie.find(params[:id])
      movie.update(params)
      movie
    end

  end
end