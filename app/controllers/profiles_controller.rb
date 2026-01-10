class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to edit_profile_path(@profile), notice: "プロフィールを作成しました"
    else
      render :edit
    end
  end

  def edit
    @profile = current_user.profile || current_user.build_profile(profile_name: current_user.login_name)
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to edit_profile_path(@profile), notice: 'プロフィールを更新しました'
    else
      render :edit
    end
  end


  private

  def profile_params
    params.require(:profile).permit(:profile_name, :introduction, :avatar, :cat_count)
  end
end
