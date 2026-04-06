class ApplicationController < ActionController::Base

  #古すぎるブラウザからのアクセスを自動でお断りする
  allow_browser versions: :modern
  
  # Deviseの時だけを一番下のアクションを実行
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # 全ページでログインを必須にする
  before_action :authenticate_user!
  
  #外から呼ぶ必要がないものは、一律で鍵（protected/private）をかける
  protected

  # ログイン後の行き先→アカウントページ
  def after_sign_in_path_for(resource)
    account_path
  end

  # 新規登録後の行き先→アカウントページ
  def after_sign_up_path_for(resource)
    account_path
  end

  # 名前(login_name)の保存許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:login_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:login_name])
  end
end