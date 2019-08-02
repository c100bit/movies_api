Rspec.describe Mutations::RemoveMovie do
  subject { described_class.new(object: nil, context: {}) }

  describe 'deleting a movie' do
    let(:movie) { create(:movie_with_genres) }

    it 'removes a movie' do
      args = { id: movie.id }
      subject.resolve(args)
      expect(Movie.count).to eq 0
    end 
 
    it 'returns a movie' do
      args = { id: movie.id }
      movie = subject.resolve(args)
      expect(movie).to eq movie
    end
 
  end
end
