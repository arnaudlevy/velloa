# == Schema Information
#
# Table name: letters
#
#  id          :bigint           not null, primary key
#  ending_at   :date
#  starting_at :date
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Letter < ApplicationRecord

  def themes
    Theme.where(id: theme_ids)
  end

  def theme_ids
    articles.map { |article| article.themes.pluck(:id) }.flatten.uniq
  end

  def articles
    Article.where('articles.created_at >= ? AND articles.created_at <= ?', starting_at.to_date, ending_at.to_date)
  end

  def dates
    "#{starting_at.strftime '%d/%m'} - #{ending_at.strftime '%d/%m/%Y'}"
  end

  def to_s
    "#{title}"
  end
end
