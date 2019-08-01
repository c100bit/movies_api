module Types
  class MutationType < Types::BaseObject
    field :editMovie, mutation: Mutations::EditMovie
    field :removeMovie, mutation: Mutations::RemoveMovie
    field :createMovie, mutation: Mutations::CreateMovie
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
