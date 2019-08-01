class ChangeTitleInGenres < ActiveRecord::Migration[6.0]
  def change
    change_column :genres, :title, :string, null: false
  end
end
