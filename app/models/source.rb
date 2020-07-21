# == Schema Information
#
# Table name: sources
#
#  id         :bigint           not null, primary key
#  country    :string
#  image      :text
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Source < ApplicationRecord
  has_many :articles, dependent: :destroy

  default_scope { order(:name) }

  def self.from_url(url)
    uri = URI(url)
    domain = "#{uri.scheme}://#{uri.host}"
    page = Curation::Page.new domain
    source = where(url: domain).first_or_initialize
    if source.new_record?
      source.name = page.title
      source.image = page.image
      source.save
    end
    source
  end

  def country_name
    c = ISO3166::Country[self.country]
    return nil if c.nil?
    c.translations[I18n.locale.to_s] || c.name
  end

  def to_s
    "#{name}"
  end
end
