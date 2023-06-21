class Admin::UsersController < ApplicationController
  def index
    @users = User.all.includes(:tasks) #n1問題
  end

  def create
    @user = User.new(user_pramas)
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  
end
