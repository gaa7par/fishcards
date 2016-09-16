class User::FlashcardsController < User::UserController
  before_action :get_language, except: :check_answer
  before_action :get_flashcard, only: [:show, :edit, :update, :destroy, :check_answer]

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

  def check_answer
    if @flashcard.back.downcase == params[:back].downcase
      render :correct, layout: false

      current_user.points += 1
      current_user.save!
    else
      render :check_answer, layout: false
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
