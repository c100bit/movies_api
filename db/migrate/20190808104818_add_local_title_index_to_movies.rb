class AddLocalTitleIndexToMovies < ActiveRecord::Migration[6.0]
  def change
    execute "CREATE INDEX trgm_index_movies_local_title ON movies USING gin (local_title gin_trgm_ops);"
  end
end
