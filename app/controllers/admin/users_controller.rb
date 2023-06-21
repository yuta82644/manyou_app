class Admin::UsersController < ApplicationController
  before_action :if_not_admin

  def index
    @users = User.all.includes(:tasks) #n1問題
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "情報をへんしゅうしました"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザーを削除しました"
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :admin,
    )
  end

  def if_not_admin
    unless current_user.admin?
      flash[:notice] = "アクセスできません"
      redirect_to tasks_path
    end
  end
end
