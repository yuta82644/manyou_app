class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  private


  def login_required
    redirect_to new_session_path unless current_user
  end

  def after_sign_in_path_for(resource)
    tasks_path
  end

  def after_sign_out_path_for
    new_session_path
  end
end

#ログインしたら一覧ページへ
