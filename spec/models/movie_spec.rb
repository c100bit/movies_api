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

  context "when create" do
    let(:movie) { create(:movie_with_genres) } 
    it { expect(movie.persisted?).to eq(true) }
    it { expect(movie.image).to be_attached }
  end
end
 