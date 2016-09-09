class User::FlashcardsController < ApplicationController
  before_action :authenticate_user!

  before_action :get_language
  before_action :get_flashcard, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @flashcard = Flashcard.new
  end

  def edit
    authorize @flashcard
  end

  def create
    @flashcard = @language.flashcards.new(flashcard_params.merge(user_id: current_user.id))

    if @flashcard.save
      redirect_to [:user, @language, @flashcard]
    else
      render 'new'
    end
  end

  def update
    authorize @flashcard
    if @flashcard.update(flashcard_params)
      redirect_to [:user, @language, @flashcard]
    else
      render 'edit'
    end
  end

  def destroy
    authorize @flashcard
    if @flashcard.destroy
      redirect_to [:user, @language]
    else
      render 'index'
    end
  end

  private

  def flashcard_params
    params.require(:flashcard).permit(:front, :back)
  end

  def get_language
    @language = Language.find(params[:language_id])
  end

  def get_flashcard
    @flashcard = Flashcard.find(params[:id])
  end
end
