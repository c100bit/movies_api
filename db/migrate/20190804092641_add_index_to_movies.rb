class AddIndexToMovies < ActiveRecord::Migration[6.0]
  def change
    add_index :movies, 'lower(title)'
    add_index :movies, :year
    add_index :movies, :rate
  end
end
