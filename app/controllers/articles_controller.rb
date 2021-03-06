class ArticlesController < ApplicationController
  load_and_authorize_resource
  skip_before_action :verify_authenticity_token, only: [:from_url]

  def index
    @articles = @articles.page params[:page]
  end

  def show
  end

  def from_url
    @url = params[:article][:url]
    @url = @url.split('?').first
    @html = params[:article][:html]
    @article = Article.from_url @url, @html
    respond_to do |format|
      format.html { redirect_to @article }
      format.json { render json: { article: @article }, status: :ok }
    end
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def article_params
    params.require(:article).permit(:source_id, :url, :title, :text, :analysis, :image, theme_ids: [])
  end
end
