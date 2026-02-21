class UsersController < ApplicationController

  def account
    @user = current_user
    @profile = current_user.profile || current_user.build_profile
  end
end
