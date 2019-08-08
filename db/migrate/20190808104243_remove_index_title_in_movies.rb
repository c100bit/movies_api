class RemoveIndexTitleInMovies < ActiveRecord::Migration[6.0]
  def change
    remove_index :movies, name: :index_movies_on_lower_title
  end
end
