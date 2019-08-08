class CreateExtPgTrgmInDb < ActiveRecord::Migration[6.0]
  def change
    execute 'CREATE EXTENSION IF NOT EXISTS pg_trgm;'
  end
end
