class Country
  attr_reader :id

  def self.all
    Source.where.not(country: [nil, ''])
          .pluck(:country)
          .uniq
          .sort
          .map { |id| Country.new id }
  end

  def self.find(id)
    Country.new id
  end

  def initialize(id)
    @id = id
  end

  def articles
    @articles ||= Article.where(source: sources)
  end

  def sources
    @sources ||= Source.where(country: id)
  end

  def to_s
    "#{ISO3166::Country[id]}"
  end
end
