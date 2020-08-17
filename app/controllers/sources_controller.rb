class SourcesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    @articles = @source.articles.page params[:page]
  end

  def new
    @source = Source.new
  end

  def edit
  end

  def create
    @source = Source.new(source_params)

    respond_to do |format|
      if @source.save
        format.html { redirect_to @source, notice: 'Source was successfully created.' }
        format.json { render :show, status: :created, location: @source }
      else
        format.html { render :new }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @source.update(source_params)
        format.html { redirect_to @source, notice: 'Source was successfully updated.' }
        format.json { render :show, status: :ok, location: @source }
      else
        format.html { render :edit }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @source.destroy
    respond_to do |format|
      format.html { redirect_to sources_url, notice: 'Source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def source_params
    params.require(:source).permit(:name, :url, :image, :country_id)
  end
end
