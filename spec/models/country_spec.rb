require 'rails_helper'

RSpec.describe Country, type: :model do

  context "when Factory" do
    it { expect(build(:country)).to be_valid } 
  end 
  
  context 'when validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).case_insensitive }
  end

  context 'when associations' do
    it { should have_many(:movies) }
  end
  
  context "when create" do
    let(:country) { create(:country) }
    it { expect(country.persisted?).to eq(true) }
    it { expect(country.title).to eq(country.title.capitalize)}
  end
end
 