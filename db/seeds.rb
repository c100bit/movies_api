include ActionDispatch::TestProcess

# 10.times { Country.create(title: Faker::Address.country) }
# 10.times { Genre.create(title: Faker::Book.genre) }

image_path = Rails.root.join('spec', 'factories', 'assets', 'movie.png')

10.times do
  genres = Genre.order('RANDOM()').limit(3)
  country = Country.order('RANDOM()').first
  Movie.create(
    title: Faker::Lorem.sentence,
    local_title: Faker::Lorem.sentence,
    year: Faker::Number.between(from: 1900, to: Time.now.year),
    rate: Faker::Number.between(from: 0, to: 10),
    text: Faker::Lorem.paragraph,
    image: fixture_file_upload(image_path, 'image/png'),
    country: country,
    genres: genres
  )
end