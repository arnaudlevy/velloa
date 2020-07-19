# == Schema Information
#
# Table name: create_join_table_theme_articles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  theme_id   :bigint           not null
#
# Indexes
#
#  index_create_join_table_theme_articles_on_article_id  (article_id)
#  index_create_join_table_theme_articles_on_theme_id    (theme_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (theme_id => themes.id)
#
require 'test_helper'

class CreateJoinTableThemeArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
