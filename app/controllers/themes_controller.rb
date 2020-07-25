class ThemesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    @articles = @theme.articles.page params[:page]
  end

  def new
    @theme = Theme.new
  end

  def edit
  end

  def create
    @theme = Theme.new(theme_params)

    if @theme.save
      redirect_to @theme, notice: 'Theme was successfully created.'
    else
      render :new
    end
  end

  def update
    if @theme.update(theme_params)
      redirect_to @theme, notice: 'Theme was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @theme.destroy
    redirect_to themes_url, notice: 'Theme was successfully destroyed.'
  end

  private

  def theme_params
    params.require(:theme).permit(:name, :keywords)
  end
end
