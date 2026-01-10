class UsersController < ApplicationController
  before_action :authenticate_user!

  def account
    @user = current_user
    @profile = current_user.profile || current_user.build_profile
  end
end
