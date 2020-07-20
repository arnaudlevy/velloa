# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  analysis   :text
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
  has_and_belongs_to_many :themes
  belongs_to :source

  scope :for_theme, -> (theme) { joins(:themes).where(themes: { id: theme }) }
  default_scope { order(created_at: :desc) }

  after_save :find_themes

  def self.from_url(url)
    article = where(url: url).first_or_initialize
    page = Curation::Page.new url
    article.title = page.title
    article.text = page.text
    article.image = page.image
    article.source = Source.from_url url
    article.save
    article
  end

  def to_s
    "#{title}"
  end

  protected

  def find_themes
    return if themes.any?
    Theme.all.each do |theme|
      themes << theme if theme.seems_to_relate_to? self
    end
  end
end
