require 'rails_helper'

RSpec.describe Genre, type: :model do

  context "when Factory" do
    it { expect(build(:genre)).to be_valid } 
  end 
  
  context 'when validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).case_insensitive }
  end

  context "when create" do
    let(:genre) { create(:genre) } 
    it { expect(genre.persisted?).to eq(true) }
    it { expect(genre.title).to eq(genre.title.capitalize)}
  end
end
 