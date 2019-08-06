FactoryBot.define do
  img_path = Rails.root.join('spec', 'factories', 'assets', 'movie.png')
  factory :movie do
    title { Faker::Lorem.sentence }
    local_title { Faker::Lorem.sentence }
    year { Faker::Number.between(from: 1900, to: Time.now.year) }
    rate { Faker::Number.between(from: 0, to: 10) }
    text { Faker::Lorem.paragraph }
    image { 
      fixture_file_upload(img_path, 'image/png') 
    }
    country
    factory :movie_with_genres do
      transient do
        genres_count { 5 }
      end
      after(:create) do |movie, evaluator|
        create_list(:genre, evaluator.genres_count, movies: [movie])
      end
    end
  end
end