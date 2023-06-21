class SessionsController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path #ログインすると一覧ページへ
    else
      flash.now[:danger] = "ログイン失敗"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "ログアウトしました"
    redirect_to new_session_path
  end
end
