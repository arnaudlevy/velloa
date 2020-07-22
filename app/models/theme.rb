# == Schema Information
#
# Table name: themes
#
#  id         :bigint           not null, primary key
#  keywords   :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Theme < ApplicationRecord
  has_and_belongs_to_many :articles

  default_scope { order(:name) }

  def seems_to_relate_to?(article)
    string = "#{article.title} #{article.text}".downcase
    keywords_array.each do |keyword|
      k = keyword.strip.downcase
      next if k.blank?
      return true if k.in? string
    end
    false
  end

  def to_s
    "#{name}"
  end

  protected

  def keywords_array
    keywords.to_s.split(',')
  end
end
