class UsersController < User::UserController
  before_action :get_user, only: [:show, :edit, :update]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).order(points: :desc)
  end

  def show
    @rates = Rate.all.where(rater_id: @user.id).page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end

  def get_user
    @user = User.find(params[:id])
  end
end
