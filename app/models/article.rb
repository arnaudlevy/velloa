# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  image      :text
#  text       :text
#  title      :string
#  url        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  source_id  :bigint           not null
#
# Indexes
#
#  index_articles_on_source_id  (source_id)
#
# Foreign Keys
#
#  fk_rails_...  (source_id => sources.id)
#
class Article < ApplicationRecord
  belongs_to :source

  def self.from_url(url)
    curator = Curator.new url
    article = where(url: url).first_or_initialize
    article.title = curator.title
    article.text = curator.text
    article.image = curator.image
    article.source = Source.from_url url
    article.save
    article
  end

  def to_s
    "#{title}"
  end
end
