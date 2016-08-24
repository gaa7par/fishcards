class User::FlashcardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @flashcards = Flashcard.all
  end

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
    @flashcard = Flashcard.new(flashcard_params)

    if @flashcard.save
      redirect_to [:user, @flashcard]
    else
      render 'new'
    end
  end

  def update
    @flashcard = Flashcard.find(params[:id])

    if @flashcard.update(flashcard_params)
      redirect_to [:user, @flashcard]
    else
      render 'edit'
    end
  end

  def destroy
    @flashcard = Flashcard.find(params[:id])
    @flashcard.destroy

    redirect_to [:user, @flashcard]
  end

  private

  def flashcard_params
    params.require(:flashcard).permit(:front, :back)
  end
end
