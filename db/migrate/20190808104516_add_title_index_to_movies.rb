class AddTitleIndexToMovies < ActiveRecord::Migration[6.0]
  def change
    execute "CREATE INDEX trgm_index_movies_title ON movies USING gin (title gin_trgm_ops);"
  end
end
