module Types
  class GenreType < Types::Base::Object
    field :id, ID, null: false
    field :title, String, null: false
    field :movies, [Types::MovieType], null: true
  end
end
