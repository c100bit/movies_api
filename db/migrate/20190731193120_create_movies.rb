class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :local_title
      t.date :year
      t.integer :rate
      t.text :text
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
