module Types
  class MovieType < Types::Base::Object
    field :id, ID, null: false
    field :title, String, null: false
    field :local_title, String, null: false
    field :year, Integer, null: false
    field :rate, Integer, null: false
    field :text, String, null: false
    field :image, String, null: false
    field :genres, [Types::GenreType], null: true
  end
end
