class AddCountryToSource < ActiveRecord::Migration[6.0]
  def change
    add_column :sources, :country, :string
  end
end
