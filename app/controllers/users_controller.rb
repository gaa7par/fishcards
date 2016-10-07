# frozen_string_literal: true
class UsersController < User::UserController
  before_action :user, only: [:show, :edit, :update, :ban, :unban]

  def index
    @query = User.ransack(params[:q])
    @users = @query.result.page(params[:page]).order(points: :desc)
  end

  def show
    @rates = Rate.where(rater_id: @user.id).page(params[:page])
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

  def ban
    @user.banned = true
    @user.save!

    redirect_to @user
  end

  def unban
    @user.banned = false
    @user.save!

    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end

  def user
    @user = User.find(params[:id])
  end
end
