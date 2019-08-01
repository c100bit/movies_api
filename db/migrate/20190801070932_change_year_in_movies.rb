class ChangeYearInMovies < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :year
    add_column :movies, :year, :integer, null: false
  end
end
