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

  def self.from_url(url)
    uri = URI(url)
    domain = "#{uri.scheme}://#{uri.host}"
    source = where(url: domain).first_or_initialize
    curator = Curator.new domain
    source.name = curator.title if source.name.nil?
    source.image = curator.image if source.image.nil?
    source.save
    source
  end

  def to_s
    "#{name}"
  end
end
