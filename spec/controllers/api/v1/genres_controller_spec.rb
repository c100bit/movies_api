require 'rails_helper'

RSpec.describe Api::V1::CountriesController, type: :controller do

  describe 'GET index' do
    let(:count_items) { 5 }
    let!(:countries) { create_list(:country, count_items) }
    let(:country) { countries.first }

    it 'returns status ok' do
      get :index
      expect_status :ok
    end

    it 'has type country' do
      get :index
      expect_record country, type: 'country'
    end

    it 'returns all items' do
      get :index
      expect_item_count count_items
    end

    it 'checks title attr' do
      get :index
      expect_attributes title: country.title
    end
  end

end
