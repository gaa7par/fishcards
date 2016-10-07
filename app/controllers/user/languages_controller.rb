# frozen_string_literal: true
class User::LanguagesController < User::UserController
  before_action :get_language, only: [:show, :edit, :update, :destroy]

  def index
    @query = Language.ransack(params[:q])
    @languages = @query.result(distinct: true).page(params[:page])
  end

  def show
    @flashcards = @language.flashcards.where.not(id: nil).page(params[:page])
  end

  def new
    @language = Language.new
  end

  def edit
    authorize @language
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
    authorize @language
    if @language.update(language_params)
      redirect_to [:user, @language]
    else
      render 'edit'
    end
  end

  def destroy
    authorize @language

    @language.destroy
    redirect_to user_languages_path
  end

  private

  def language_params
    params.require(:language).permit(:name)
  end

  def get_language
    @language = Language.find(params[:id])
  end
end
