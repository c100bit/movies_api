require 'rails_helper'

RSpec.describe Country, type: :model do

  context "when Factory" do
    it { expect(build(:country)).to be_valid } 
  end 
  
  context 'when validations' do
    it { should validate_presence_of(:title) }
    describe 'uniqueness' do
      subject { build(:country) }  
      it { should validate_uniqueness_of(:title).case_insensitive }
    end
  end

  context 'when associations' do
    it { should have_many(:movies) }
  end
  
  context "when creates" do
    let(:country) { create(:country) }
    it { expect(country.persisted?).to eq(true) }
    it { expect(country.title).to eq(country.title.capitalize) }
  end
end
 