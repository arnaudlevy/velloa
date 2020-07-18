class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :source, null: false, foreign_key: true
      t.text :url
      t.string :title
      t.text :text
      t.text :image

      t.timestamps
    end
  end
end
