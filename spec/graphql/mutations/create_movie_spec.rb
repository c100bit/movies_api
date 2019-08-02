Rspec.describe Mutations::CreateMovie do
  subject { described_class.new(object: nil, context: {}) }

  describe 'creating a movie' do
    let(:country) { create(:country) }
    let(:genres) { create_list(:genre, 3) }
    let(:args) { 
      attributes_for(:movie)
        .merge!(country_id: country.id, genre_ids: genres.map(&:id)) 
    }

    it 'creates a movie' do
      expect { subject.resolve(args) }.to change { Movie.count }.by(1)
    end  

    it 'returns a movie' do
      movie = subject.resolve(args)
      expect(movie).to be_a(Movie)
    end
    
  end
end
