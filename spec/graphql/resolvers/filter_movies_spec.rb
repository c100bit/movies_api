Rspec.describe Resolvers::FilterMovies do
  subject { described_class.new(object: nil, context: {}) }

  describe 'filter movies' do
    let!(:movies) { create_list(:movie, 5) }
    
    it 'returns all movies without filter' do
      query = subject.resolve(field: 'other', val: 'other')
      expect(query.count).to eq Movie.count
    end
  
    it 'returns movies filtered by title' do
      title = Faker::Lorem.sentence
      create_list(:movie, 3, title: title)
      query = subject.resolve(field: 'title', val: title)
      movies_db = Movie.filter_by('title', title)
      expect(query).to eq movies_db
    end
 
    it 'returns movies filtered by year' do
      year = Faker::Number.between(from: 1900, to: Time.now.year)
      create_list(:movie, 3, year: year)
      query = subject.resolve(field: 'year', val: year)
      movies_db = Movie.filter_by('year', year) 
      expect(query).to eq movies_db
    end   
   
    it 'returns movies filtered by genre_ids' do
      genres = create_list(:genre, 3)
      genre_ids = genres.map(&:id)
      create_list(:movie, 3, genres: genres)
      query = subject.resolve(field: 'genre_ids', val: genre_ids.join(','))
      movies_db = Movie.filter_by_genres(genre_ids)
      expect(query).to eq movies_db
    end 

    it 'returns movies filtered by rate' do
      rate = Faker::Number.between(from: 0, to: 10)
      create_list(:movie, 3, rate: rate)
      query = subject.resolve(field: 'rate', val: rate)
      movies_db = Movie.filter_by('rate', rate)
      expect(query).to eq movies_db
    end

    it 'returns movies filtered by country_id' do
      country = create(:country)
      create_list(:movie, 3, country: country)
      query = subject.resolve(field: 'country_id', val: country.id)
      movies_db = Movie.filter_by('country_id', country.id)
      expect(query).to eq movies_db
    end  
  end
end    