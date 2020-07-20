class AddAnalysisToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :analysis, :text
  end
end
