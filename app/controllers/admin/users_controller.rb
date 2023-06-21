class Admin::UsersController < ApplicationController
  def index
    @users = User.all.includes(:tasks) #n1問題
  end

  def new
    respond_to do |format|
format.html # This line was already here.
end
  end

  def create
    @user = User.new(user_pramas)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end
end
