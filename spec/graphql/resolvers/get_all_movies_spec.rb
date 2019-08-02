Rspec.describe Resolvers::GetAllMovies do
  subject { described_class.new(object: nil, context: {}) }

  describe 'fetching movies' do
    let!(:movies) { create_list(:movie, 5) }

    it 'returns all movies' do
      query = subject.resolve
      expect(query.count).to eq Movie.count
    end

  end
end  