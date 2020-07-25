class LettersController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
    @letter = Letter.new
  end

  def edit
  end

  def create
    @letter = Letter.new(letter_params)

    if @letter.save
      redirect_to @letter, notice: 'Letter was successfully created.'
    else
      render :new
    end
  end

  def update
    if @letter.update(letter_params)
      redirect_to @letter, notice: 'Letter was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @letter.destroy
    redirect_to letters_url, notice: 'Letter was successfully destroyed.'
  end

  private

  def letter_params
    params.require(:letter).permit(:starting_at, :ending_at, :title)
  end
end
