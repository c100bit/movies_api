class ChangeTitleInCountry < ActiveRecord::Migration[6.0]
  def change
    change_column :countries, :title, :string, null: false
  end
end
