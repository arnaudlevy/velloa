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

  before_validation :build_from_url

  protected

  def build_from_url
    self.title = metainspector.best_title if title.nil?
    self.text = metainspector.best_description if text.nil?
    self.image = metainspector.images.best if image.nil?
    if source.nil?
      uri = URI(url)
      source_url = "#{uri.scheme}://#{uri.host}"
      source = Source.where(url: source_url).first_or_initialize
      source_mi = MetaInspector.new source_url
      source.name = source_mi.best_title
      source.save
      self.source = source
    end
  end

  def metainspector
    @metainspector ||= MetaInspector.new self.url
  end
end
