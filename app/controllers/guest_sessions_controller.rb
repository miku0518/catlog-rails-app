class GuestSessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    user = User.guest
    sign_in user  #ユーザーをログイン状態にする
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました"
  end
end
