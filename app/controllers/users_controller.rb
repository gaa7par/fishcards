class UsersController < User::UserController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.sort_by { |user| user.points }.reverse
  end

  def show
    @user = User.find(params[:id])
  end
end
