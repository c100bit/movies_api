module Mutations
  class RemoveMovie < BaseMutation
    argument :id, ID, required: true

    type Types::MovieType
    
    def resolve(id:)
      movie = Movie.find(id)
      movie.destroy
    end

  end
end
 