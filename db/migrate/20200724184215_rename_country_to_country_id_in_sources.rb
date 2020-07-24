class RenameCountryToCountryIdInSources < ActiveRecord::Migration[6.0]
  def change
    rename_column :sources, :country, :country_id
  end
end
