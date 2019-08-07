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

    context 'when movies are sorted' do
      let(:items_count) { 5 }
      let!(:movies) { create_list(:movie, items_count) }

      it 'returns all movies with wrong order field' do
        get :index, params: { order: 'other' }
        expect_item_count items_count 
      end

      it 'returns movies ordered by year desc(default)' do
        get :index, params: { order: 'year' }
        expect_records_sorted_by :year, direction: :desc
      end 

      it 'returns movies ordered by rate asc' do
        get :index, params: { order: 'rate', asc: true }
        expect_records_sorted_by :rate, direction: :asc
      end 
    end

    context 'when movies are filtered' do
      let(:items_count) { 5 }
      let!(:movies) { create_list(:movie, items_count) }

      it 'returns all movies with wrong filter field' do
        get :index, params: { filter: 'other', val: 'other' }
        expect_item_count items_count
      end
      
      it 'returns all movies with val is null' do
        get :index, params: { filter: 'title' }
        expect_item_count items_count
      end
      
      it 'returns movies filtered by title' do
        title = Faker::Lorem.sentence
        create_list(:movie, 3, title: title)
        get :index, params: { filter: 'title', val: title }
        movies_db = Movie.filter_by_title(title)
        expect(json_body[:data].pluck(:id).map(&:to_i)).to eq movies_db.pluck(:id)
      end
  
      it 'returns movies filtered by year' do
        year = Faker::Number.between(from: 1900, to: Time.now.year)
        create_list(:movie, 3, year: year)
        get :index, params: { filter: 'year', val: year }
        movies_db = Movie.filter_by('year', year) 
        expect(json_body[:data].pluck(:id).map(&:to_i)).to eq movies_db.pluck(:id)
      end   
    
      it 'returns movies filtered by genre_ids' do
        genres = create_list(:genre, 3)
        genre_ids = genres.pluck(:id)
        create_list(:movie, 3, genres: genres)
        get :index, params: { filter: 'genre_ids', val: genre_ids.join(',') }
        movies_db = Movie.filter_by_genres(genre_ids)
        expect(json_body[:data].pluck(:id).map(&:to_i)).to eq movies_db.pluck(:id)
      end 

      it 'returns movies filtered by rate' do
        rate = Faker::Number.between(from: 0, to: 10)
        create_list(:movie, 3, rate: rate)
        get :index, params: { filter: 'rate', val: rate }
        movies_db = Movie.filter_by('rate', rate)
        expect(json_body[:data].pluck(:id).map(&:to_i)).to eq movies_db.pluck(:id)
      end

      it 'returns movies filtered by country_id' do
        country = create(:country)
        create_list(:movie, 3, country: country)
        get :index, params: { filter: 'country_id', val: country.id }
        movies_db = Movie.filter_by('country_id', country.id)
        expect(json_body[:data].pluck(:id).map(&:to_i)).to eq movies_db.pluck(:id)
      end  
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
      attr = { genre_ids: genres.pluck(:id) }
      put :update, params: { id: movie, movie: attr }
      expect(Movie.first.genres.to_a).to eq genres
    end 
  end

  describe 'POST create' do
    let(:country) { create(:country) }
    let(:genres) { create_list(:genre, 3) }
    let(:args) do 
      attributes_for(:movie)
        .merge!(country_id: country.id, genre_ids: genres.pluck(:id)) 
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
      attr = { genre_ids: genres.pluck(:id) }
      put :update, params: { id: movie, movie: attr }
      expect(Movie.first.genres.to_a).to eq genres
    end 
  end

end
