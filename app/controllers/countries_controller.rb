class CountriesController < ApplicationController
  def index
    @countries = Country.all
  end

  def show
    @country = Country.find params[:id]
    @articles = @country.articles.page params[:page]
  end
end
