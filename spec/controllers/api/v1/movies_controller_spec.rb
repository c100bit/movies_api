require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do
 
  describe 'GET index' do
    let(:count_items) { 5 }
    let!(:movies) { create_list(:movie_with_genres, count_items) }
    let(:movie) { movies.first }

    before(:each) { get :index }

    it 'returns status ok' do
      expect_status :ok
    end

    it 'has type movie' do
      expect_record movie, type: 'movie'
    end

    it 'returns all items' do
      expect_item_count count_items
    end

    it 'has attrs' do
      expect_attributes year: movie.year, text: movie.text,
        rate: movie.rate, title: movie.title,
        local_title: movie.local_title,
        image_url: movie.image_url
    end

    it 'has relationship country' do
      expect_relationship key: 'country'
    end

    it 'has relationship genres' do
      expect_relationship key: 'genres'
    end
  end

  describe 'GET show' do
    let!(:movie) { create(:movie) }

    before(:each) { get :show, params: { id: movie } }

    it 'returns status ok' do
      expect_status :ok
    end

    it 'returns movie' do
      expect_record movie, type: 'movie'
    end

    it 'has attrs' do
      expect_attributes year: movie.year, text: movie.text,
        rate: movie.rate, title: movie.title,
        local_title: movie.local_title,
        image_url: movie.image_url
    end

    it 'has relationship country' do
      expect_relationship key: 'country'
    end

    it 'has relationship genres' do
      expect_relationship key: 'genres'
    end
  end

  describe 'DELETE destroy' do
    before(:each) { @movie = create(:movie) }

    it 'returns status no content' do
      delete :destroy, params: { id: @movie } 
      expect_status :no_content
    end

    it 'checks movie was removed' do
      action = -> { delete :destroy, params: { id: @movie } }
      expect(action).to change { Movie.count }.by(-1)
    end 
  end

  describe 'PATCH/PUT update' do
    let!(:movie) { create(:movie_with_genres) }

    it 'returns status ok' do
      attr = { title: Faker::Lorem.sentence }
      put :update, params: { id: movie, movie: attr }
      expect_status :ok
    end

    it 'updates attrs' do
      attr = { title: Faker::Lorem.sentence, text: Faker::Lorem.sentence, 
        year: 1990, rate: 10, local_title: Faker::Lorem.sentence
      }
      put :update, params: { id: movie, movie: attr }
      expect_attributes attr
    end

    it 'updates a image' do
      image_name = 'test.png'
      img_path = Rails.root.join('spec', 'factories', 'assets', image_name)
      attr = { image: fixture_file_upload(img_path, 'image/png') }
      put :update, params: { id: movie, movie: attr }
      expect(Movie.first.image_url).to end_with "/#{image_name}"
    end 

    it 'updates a country' do
      country = create(:country)
      attr = { country_id: country }
      put :update, params: { id: movie, movie: attr }
      expect(Movie.first.country).to eq country
    end 

    it 'updates genres' do
      genres = create_list(:genre, 3)
      attr = { genre_ids: genres.map(&:id) }
      put :update, params: { id: movie, movie: attr }
      expect(Movie.first.genres.to_a).to eq genres
    end 
  end

  describe 'POST create' do
    let(:country) { create(:country) }
    let(:genres) { create_list(:genre, 3) }
    let(:args) do 
      attributes_for(:movie)
        .merge!(country_id: country.id, genre_ids: genres.map(&:id)) 
    end

    before(:each) { post :create, params: { movie: args } }
    
    it 'returns status created' do
      expect_status :created
    end

    it 'returns new movie' do
      expect_record Movie.first, type: 'movie'
    end

    it 'creates a movie' do
      action = -> { post :create, params: { movie: args } }
      expect(action).to change { Movie.count }.by(1)
    end  
  end

end
