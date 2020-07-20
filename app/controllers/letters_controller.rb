class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy]

  # GET /letters
  def index
    @letters = Letter.all
  end

  # GET /letters/1
  def show
  end

  # GET /letters/new
  def new
    @letter = Letter.new
  end

  # GET /letters/1/edit
  def edit
  end

  # POST /letters
  def create
    @letter = Letter.new(letter_params)

    if @letter.save
      redirect_to @letter, notice: 'Letter was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /letters/1
  def update
    if @letter.update(letter_params)
      redirect_to @letter, notice: 'Letter was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /letters/1
  def destroy
    @letter.destroy
    redirect_to letters_url, notice: 'Letter was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_letter
      @letter = Letter.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def letter_params
      params.require(:letter).permit(:starting_at, :ending_at, :title)
    end
end
