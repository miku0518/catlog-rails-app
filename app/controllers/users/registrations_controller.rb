class Users::RegistrationsController < Devise::RegistrationsController
  layout "application"

  protected
  def after_sign_up_path_for(resource)
    account_path   # ← これで新規登録後にアカウントページに飛ぶ
  end

  def after_sign_in_path_for(resource)
    account_path
  end
end