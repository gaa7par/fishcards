class User::LanguagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @languages = Language.all
  end

  def show
    @language = Language.find(params[:id])

    @flashcards = @language.flashcards.where.not(id: nil)
  end

  def new
    @language = Language.new
  end

  def edit
    @language = Language.find(params[:id])
  end

  def create
    @language = current_user.languages.new(language_params)

    authorize @language
    if @language.save
      redirect_to [:user, @language]
    else
      render 'new'
    end
  end

  def update
    @language = Language.find(params[:id])

    authorize @language
    if @language.update(language_params)
      redirect_to [:user, @language]
    else
      render 'edit'
    end
  end

  def destroy
    @language = Language.find(params[:id])

    authorize @language
    if @language.destroy
      redirect_to [:user, @language]
    else
      render 'index'
    end
  end

  private

  def language_params
    params.require(:language).permit(:name)
  end
end
