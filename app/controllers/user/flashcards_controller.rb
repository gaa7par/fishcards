class User::FlashcardsController < User::UserController
  before_action :language, except: :check_answer
  before_action :flashcard, only: [:show, :edit, :update, :destroy, :check_answer]

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

    @flashcard.destroy
    redirect_to [:user, @language]
  end

  def check_answer
    if @flashcard.the_same?(params)
      current_user.points += 1
      current_user.save!

      render :correct, layout: false
    else
      render :incorrect, layout: false
    end
  end

  private

  def flashcard_params
    params.require(:flashcard).permit(:front, :back)
  end

  def language
    @language = Language.find(params[:language_id])
  end

  def flashcard
    @flashcard = Flashcard.find(params[:id])
  end
end
