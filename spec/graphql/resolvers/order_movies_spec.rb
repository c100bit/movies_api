Rspec.describe Resolvers::OrderMovies do
  subject { described_class.new(object: nil, context: {}) }

  describe 'order movies' do
    let!(:movies) { create_list(:movie, 5) }

    it 'returns all movies without order' do
      query = subject.resolve(by: 'other', asc: true)
      expect(query.count).to eq Movie.count
    end

    it 'returns movies ordered by year desc' do
      query = subject.resolve(by: 'year', asc: false)
      movies_db = Movie.order(year: :desc)
      expect(query.map(&:id)).to eq movies_db.map(&:id)
    end 

    it 'returns movies ordered by rate asc' do
      query = subject.resolve(by: 'rate', asc: true)
      movies_db = Movie.order(rate: :asc)
      expect(query.map(&:id)).to eq movies_db.map(&:id)
    end 

  end
end  