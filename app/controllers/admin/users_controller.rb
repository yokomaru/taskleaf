class Admin::UsersController < ApplicationController
  before_action :require_admin
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_url, notice: "タスク「#{@user.name}」を登録しまし〜た"
    else
      render :new
    end
  end

  def update
    user = User.find(params[:id])
    user.update!(user_params)
    redirect_to admin_users_path, notice: "タスク「#{user.name}」を更新しまし〜た"
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: "タスク「#{user.name}」を削除しまし〜た"
  end
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を登録しまし〜た"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end