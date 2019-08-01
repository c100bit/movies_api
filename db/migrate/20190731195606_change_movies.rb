class ChangeMovies < ActiveRecord::Migration[6.0]
  def change
    change_table :movies do |t|
      t.change :title, :string, null: false
      t.change :local_title, :string, null: false
      t.change :year, :date, null: false
      t.change :rate, :integer, null: false, default: 0
      t.change :text, :text, null: false
    end
  end
end
