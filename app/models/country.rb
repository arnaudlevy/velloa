class Country
  attr_reader :id

  def self.all
    Source.where.not(country_id: [nil, ''])
          .pluck(:country_id)
          .uniq
          .sort
          .map { |id| Country.new id }
  end

  def self.find(id)
    return if id.blank?
    Country.new id
  end

  def initialize(id)
    @id = id
  end

  def articles
    @articles ||= Article.where(source: sources)
  end

  def sources
    @sources ||= Source.where(country_id: id)
  end

  def to_s
    c = ISO3166::Country[id]
    return nil if c.nil?
    c.translations[I18n.locale.to_s] || c.name
  end
end
