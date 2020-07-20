# == Schema Information
#
# Table name: sources
#
#  id         :bigint           not null, primary key
#  image      :text
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Source < ApplicationRecord
  has_many :articles

  default_scope { order(:name) }

  def self.from_url(url)
    uri = URI(url)
    domain = "#{uri.scheme}://#{uri.host}"
    page = Curation::Page.new domain
    source = where(url: domain).first_or_initialize
    source.name = page.title if source.name.blank?
    source.image = page.image if source.image.blank?
    source.save
    source
  end

  def to_s
    "#{name}"
  end
end
