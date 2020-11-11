class HomeController < ApplicationController
  def index
    @articles = Article.limit(20)
    @themes = @articles.collect(&:themes)
                        .flatten
                        .uniq
                        .sort { |a, b| a.to_s <=> b.to_s }
  end
end
