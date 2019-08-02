Rspec.describe Resolvers::GetAllCountries do
  subject { described_class.new(object: nil, context: {}) }

  describe 'fetching countries' do
    let!(:countries) { create_list(:country, 5) }

    it 'returns all countries' do
      query = subject.resolve
      expect(query.count).to eq Country.count
    end

  end
end  