class UsersController < User::UserController
  def index
    @users = (User.all.sort_by { |user| user.points }).reverse
  end

  def show
    @user = User.find(params[:id])
  end
end
