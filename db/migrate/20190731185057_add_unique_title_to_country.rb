class AddUniqueTitleToCountry < ActiveRecord::Migration[6.0]
  def change
    add_index :countries, 'lower(title)', :unique =>  true
  end
end
