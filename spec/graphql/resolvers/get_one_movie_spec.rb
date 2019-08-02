Rspec.describe Resolvers::GetOneMovie do
  subject { described_class.new(object: nil, context: {}) }

  describe 'fetching a movie' do
    let!(:movie) { create(:movie) }
    let(:query) { subject.resolve(id: movie.id) }
    
    it 'returns a movie by id' do
      expect(query.id).to eq movie.id
    end

    it 'has a title' do
      expect(query.title).to eq movie.title
    end
  
  end
end   