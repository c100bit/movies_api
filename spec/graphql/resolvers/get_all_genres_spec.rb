Rspec.describe Resolvers::GetAllGenres do
  subject { described_class.new(object: nil, context: {}) }

  describe 'fetching genres' do
    let!(:genres) { create_list(:genre, 5) }

    it 'returns all genres' do
      query = subject.resolve
      expect(query.count).to eq Genre.count
    end

  end
end  