module Root
  class MutationType < Types::Base::Object
    field :editMovie, mutation: Mutations::EditMovie,
      description: "Edit movie by id"
    field :removeMovie, mutation: Mutations::RemoveMovie,
      description: "Destroy movie by id"
    field :createMovie, mutation: Mutations::CreateMovie,
      description: "Create movie with params"
  end
end
