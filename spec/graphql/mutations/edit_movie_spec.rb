Rspec.describe Mutations::EditMovie do
  subject { described_class.new(object: nil, context: {}) }

  describe 'editing a movie' do
    let(:movie) { create(:movie_with_genres) }

    it 'updates a title' do
      title = Faker::Lorem.sentence
      args = { id: movie.id, title: title }
      subject.resolve(args)
      expect(Movie.first.title).to eq title
    end 

    it 'returns a movie' do
      args = { id: movie.id }
      movie = subject.resolve(args)
      expect(movie).to be_a(Movie)
    end

    it 'updates a country' do
      country = create(:country)
      args = { id: movie.id, country_id: country.id }
      subject.resolve(args)
      expect(Movie.first.country).to eq country
    end 

    it 'updates genres' do
      genres = create_list(:genre, 2)
      args = { id: movie.id, genre_ids: genres.map(&:id) }
      subject.resolve(args)
      expect(Movie.first.genres).to eq genres
    end 
        
  end
end
