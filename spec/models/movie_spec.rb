require 'rails_helper'

RSpec.describe Movie, type: :model do
  
  context "when Factory" do 
    it { expect(build(:movie)).to be_valid }   
  end  
    
  context 'when validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:local_title) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:rate) }
    it { should validate_presence_of(:text) }
    it { should validate_numericality_of(:rate).is_less_than_or_equal_to(10).
      is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:year).is_greater_than_or_equal_to(1900) }
  end
 
  context 'when associations' do
    it { should belong_to(:country) }
    it { should have_and_belong_to_many(:genres) }
  end 

  context "when creates" do
    let(:movie) { create(:movie_with_genres) } 
    it { expect(movie.persisted?).to eq(true) }
    it { expect(movie.image).to be_attached }
  end

  context 'when filteres' do
    before(:all) { create_list(:movie_with_genres, 5) }

    describe '.filter_by' do
      it 'returns movies filtered by year' do
        year = 5000
        movies_db = create_list(:movie, 3, year: year)     
        filtered = described_class.filter_by('year', year)
        expect(filtered).to match_array movies_db
      end
    end
    
   describe '.filter_by_title' do
      it 'returns movies filtered by title' do
        title = 'Filtered by super c!100bit title'
        movies_db = create_list(:movie, 3, title: title)     
        filtered = described_class.filter_by_title('!100bi')
        expect(filtered).to match_array movies_db 
      end

      it 'returns movies filtered by local_title' do
        title = 'Filtered by super c!100bit title'
        movies_db = create_list(:movie, 3, local_title: title)     
        filtered = described_class.filter_by_title('!100bi')
        expect(filtered).to match_array movies_db 
      end
    end 

    describe '.filter_by_genres' do
      it 'returns movies filtered by genres' do
        genres = create_list(:genre, 3)
        movies_db = create_list(:movie, 3, genres: genres)     
        filtered = described_class.filter_by_genres(genres.map(&:id))
        expect(filtered).to eq movies_db 
      end
    end
 
  end

  describe '#image_url' do
    it 'returns image path' do
      movie = create(:movie)
      image_name = movie.image.blob.filename.to_s
      expect(movie.image_url).to end_with("/#{image_name}")
    end
  end
end
 