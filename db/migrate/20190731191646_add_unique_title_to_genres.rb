class AddUniqueTitleToGenres < ActiveRecord::Migration[6.0]
  def change
    add_index :genres, 'lower(title)', :unique =>  true
  end
end
