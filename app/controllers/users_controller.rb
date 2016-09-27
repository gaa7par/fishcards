class UsersController < User::UserController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).order(points: :desc)
  end

  def show
    @user = User.find(params[:id])
    @rates = Rate.all.where(rater_id: @user.id)
  end
end
