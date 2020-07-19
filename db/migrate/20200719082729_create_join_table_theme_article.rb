class CreateJoinTableThemeArticle < ActiveRecord::Migration[6.0]
  def change
    create_join_table :themes, :articles do |t|
      t.index [:theme_id, :article_id]
      t.index [:article_id, :theme_id]
    end
  end
end
