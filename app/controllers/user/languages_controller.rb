class User::LanguagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @languages = Language.all
  end

  def show
    @language = Language.find(params[:id])
  end

  def new
    @language = Language.new
  end

  def edit
    @language = Language.find(params[:id])
  end

  def create
    @language = Language.new(language_params)

    if @language.save
      redirect_to [:user, @language]
    else
      render 'new'
    end
  end

  def update
    @language = Language.find(params[:id])

    if @language.update(language_params)
      redirect_to [:user, @language]
    else
      render 'edit'
    end
  end

  def destroy
    @language = Language.find(params[:id])
    @language.destroy

    redirect_to [:user, @language]
  end

  private

  def language_params
    params.require(:language).permit(:name)
  end
end
