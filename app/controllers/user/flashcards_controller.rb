class User::FlashcardsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_language

  def show
    @flashcard = Flashcard.find(params[:id])
  end

  def new
    @flashcard = Flashcard.new
  end

  def edit
    @flashcard = Flashcard.find(params[:id])
  end

  def create
    @flashcard = @language.flashcards.new(flashcard_params)

    if @flashcard.save
      redirect_to [:user, @language, @flashcard]
    else
      render 'new'
    end
  end

  def update
    @flashcard = Flashcard.find(params[:id])

    if @flashcard.update(flashcard_params)
      redirect_to [:user, @language, @flashcard]
    else
      render 'edit'
    end
  end

  def destroy
    @flashcard = Flashcard.find(params[:id])
    @flashcard.destroy

    # redirect_to [:user, @language, @flashcard]
    redirect_to user_languages_path
  end

  private

  def flashcard_params
    params.require(:flashcard).permit(:front, :back)
  end

  def get_language
    @language = Language.find(params[:language_id])
  end
end
